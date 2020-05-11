require_relative '../lib/scraper'
hash = { 0 => 'employer\'s name', 1 => 'job\'s title', 2 => 'city\'s name', 3 => 'year between 2012 and 2020' }
instructions = 'The value can be alphanumeric and have one space between words.'

def valid_option(number)
  until (0..4).include? number
    puts 'Please write a valid option'
    number = gets.chomp.to_i - 1
  end
  number
end

def option(number, obj, hash, instructions)
  input = ',,'
  while input.match(/[^\w]{2,}/)
    puts "Write the #{hash[number]} or press 'enter' \n"
    puts instructions
    input = gets.strip
  end
  obj.form[number] = input =~ /\w/ ? input : ''
end

def custom_options(obj, hash, instructions)
  obj.form.each_with_index do |_, y|
    input = ',,'
    if y == 3
      until ((2012..2020).include? input.to_i) || (input == '')
        puts "Write the #{hash[y]} or press 'enter' \n"
        puts instructions
        input = gets.strip
      end
      obj.form[y] = input
    else
      while input.match(/[^\w]{2,}/)
        puts "Write the #{hash[y]} or press 'enter' \n"
        puts instructions
        input = gets.strip
      end
      obj.form[y] = input =~ /\w/ ? input : ''
    end
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
puts "\n 1. Employer's name \n 2. Job Title \n 3. City \n 4. Custom"
number = gets.chomp.to_i - 1

scraper = Scraper.new
valid_result = valid_option(number)

if valid_result < 3
  option(valid_result, scraper, hash, instructions)
else
  custom_options(scraper, hash, instructions)
end

puts "\nGood! These are the values \n Employer: #{scraper.form[0]} \n Job's Title: #{scraper.form[1]}
 City: #{scraper.form[2]} \n Year: #{scraper.form[3]}"
puts "\nI'll proceed to do the search, it'll take a moment..."

url = scraper.parse_url(scraper.create_link)
findings = url.css('.tablesorter').css('tbody').css('tr').count

puts "The search returned #{findings} results"

p 'END'
