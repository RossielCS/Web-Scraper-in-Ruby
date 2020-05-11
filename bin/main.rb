require_relative '../lib/scraper'
hash = { 0 => 'employer\'s name', 1 => 'job\'s title', 2 => 'city\'s name', 3 => 'year between 2012 and 2020' }
instructions = 'The value can be alphanumeric and have one space between words.'
all_results = []

def valid_option(number)
  until (0..4).include? number
    puts 'Please write a valid option'
    number = gets.chomp.to_i - 1
  end
  number
end

def valid_name(number, obj, hash, string)
  input = ''
  loop do
    puts "\nWrite the #{hash[number]} or press 'enter' \n"
    puts string
    input = gets.strip
    break unless input.match(/[^\w]{2,}/)
  end
  obj.form[number] = input =~ /\w/ ? input : ''
end

def valid_year(obj, hash, string)
  input = ''
  loop do
    puts "\nWrite the #{hash[3]} or press 'enter' \n"
    puts string
    input = gets.strip
    break if (input == '') || ((2012..2020).include? input.to_i)
  end
  obj.form[3] = input =~ /\w/ ? input : obj.form[3]
end

def display_values(all_results)
  all_results.each do |x|
    puts " Employer: #{x.employer} \n Job Title: #{x.job_title} \n Base Salary: #{x.base_salary}
  Location: #{x.location} \n Submit Date: #{x.submit_date} \n Start Date: #{x.start_date}"
    puts "\n"
  end
end

puts "Welcome!
With this web scraper you can search information about the salary for
applicants to visa H1B of the United States.\n
All the information it's obtained of the website H1B Salary Database 'h1bdata.info'
In case that you\'re interested in what you found here, please visit the H1B Salary Database."

puts "\nTo do the search it\'s necessary to apply al least one of these filters:
 * Employer, \n * Job title or \n * City \n
By default the scrapper does the search including all the available years, which are
from 2012 to 2020."

puts "\nPlease write the number of the option.
In case that you want to add more that one filter,
you can choose the 'Custom' option to add value to any filter, even the year."
puts "\n (1) Employer's name \n (2) Job Title \n (3) City \n (4) Custom"
number = gets.chomp.to_i - 1

scraper = Scraper.new
valid_result = valid_option(number)

if valid_result < 3
  valid_name(valid_result, scraper, hash, instructions)
else
  count = 0
  loop do
    valid_name(count, scraper, hash, instructions)
    count += 1
    break if count == 3
  end
  valid_year(scraper, hash, instructions)
end

puts "\nGood! These are the values \n Employer: #{scraper.form[0]} \n Job's Title: #{scraper.form[1]}
 City: #{scraper.form[2]} \n Year: #{scraper.form[3]}"
puts "\nI'll proceed to do the search, it'll take a moment..."

url = scraper.parse_url(scraper.create_link)
findings = url.css('.tablesorter').css('tbody').css('tr').count

puts "The search returned #{findings} results"

if findings.zero?
  puts 'Do you want to search again? Write (y) to start again or (n) to exit.'
end

findings.times do |idx|
  obj = Result.new
  obj.add_values(url.css('tbody').css('tr')[idx])
  all_results << obj
end

puts 'Do you want to display all results? (y) to continue or (n) to discard them'
answer = gets.chomp
loop do
  if answer == 'y'
    display_values(all_results)
    break
  elsif answer == 'n'
    all_results = []
    break
  else
    puts 'Write a valid option.'
    answer = gets.chomp
  end
end

p 'END'
