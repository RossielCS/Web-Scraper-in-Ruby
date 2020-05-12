require_relative '../lib/scraper'
hash = { 0 => 'employer\'s name', 1 => 'job title', 2 => 'city\'s name', 3 => 'year between 2012 and 2020' }
instructions = 'The value can be alphanumeric and have one space between words.'
all_results = []
rewrite = 'Please write a valid option'

def valid_option(number, rewrite)
  until (0..4).include? number
    puts rewrite
    number = gets.chomp.to_i - 1
  end
  number
end

def name_year(scraper, valid_result, hash, instructions)
  if valid_result < 3
    valid_name(valid_result, scraper, hash, instructions)
  else
    count = 0
    loop do
      valid_name(count, scraper, hash, instructions)
      count += 1
      break if count == 3
    end
    valid_year(scraper, hash)
  end
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

def valid_year(obj, hash)
  input = ''
  loop do
    puts "\nWrite the #{hash[3]} or press 'enter' \n"
    input = gets.strip
    break if (input == '') || ((2012..2020).include? input.to_i)
  end
  obj.form[3] = input =~ /\w/ ? input : obj.form[3]
end

def display_input(scraper)
  puts "\nGood! These are the values \n\n Employer: #{scraper.form[0]} \n Job's Title: #{scraper.form[1]}
 City: #{scraper.form[2]} \n Year: #{scraper.form[3]}"
end

def display_values(all_results)
  all_results.each do |x|
    puts " Employer: #{x.employer} \n Job Title: #{x.job_title} \n Base Salary: #{x.base_salary}
 Location: #{x.location} \n Submit Date: #{x.submit_date} \n Start Date: #{x.start_date}"
    puts "\n"
  end
end

def display_discard(findings, url, all_results, rewrite)
  loop do
    answer = gets.chomp
    if answer == 'y'
      save_results(findings, url, all_results)
      break
    elsif answer == 'n'
      all_results = []
      break
    else
      puts rewrite
    end
  end
end

def save_results(findings, url, all_results)
  findings.times do |idx|
    obj = Result.new
    obj.add_values(url[idx])
    all_results << obj
  end
end

def close_scraper(rewrite)
  puts 'Would you like to do another search? (y) to continue (n) to exit.'
  loop do
    final = gets.chomp
    if final == 'y'
      puts "\nOk, let\'s start again!"
      break
    elsif final == 'n'
      puts 'Byebye'
      exit
    else
      puts rewrite
    end
  end
end

puts "Welcome!
With this web scraper, you can search information about the salaries for
applicants to the United States visa H1B.\n
All the information it's obtained from the website H1B Salary Database 'h1bdata.info'
In case you\'re interested in what you\'ve found here, please visit the H1B Salary Database."

puts "\nTo do the search it\'s necessary to apply al least one of these filters:
 * Employer, \n * Job title or \n * City \n
By default, the scrapper does the search including all the available years, which are
from 2012 to 2020."

loop do
  puts "\nPlease write the number of the option.
  In case you want to add more that one filter,
  you can choose the 'Custom' option to add value to any filter, even the year."
  puts "\n (1) Employer's Name \n (2) Job Title \n (3) City \n (4) Custom"
  number = gets.chomp.to_i - 1
  scraper = Scraper.new
  valid_result = valid_option(number, rewrite)
  name_year(scraper, valid_result, hash, instructions)

  display_input(scraper)
  puts "\nI'll proceed to do the search, it'll take a moment..."

  url = scraper.parse_url(scraper.create_link).css('tbody').css('tr')
  findings = url.count

  puts "The search returned #{findings} results"
  if findings.positive?
    puts 'Do you want to display all results? (y) to continue or (n) to discard them.'
    display_discard(findings, url, all_results, rewrite)
    display_values(all_results)
  end
  close_scraper(rewrite)
end
