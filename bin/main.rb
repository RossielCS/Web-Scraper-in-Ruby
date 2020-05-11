require_relative '../lib/scraper'
def valid_option(number)
  until (1..4).include? number
    puts 'Please write a valid option'
    number = gets.chomp.to_i
  end
  number
end

def option(number, obj)
  hash = { 1 => 'job\'s title', 2 => 'employer\'s name', 3 => 'city\'s name', 4 => 'year' }
  puts "Write the #{hash[number]}"
  name = gets.chomp
  case number
  when 1
    obj.job = name
  when 2
    obj.employer = name
  when 3
    obj.city = name
  else
    obj.year = name
  end
end

puts 'Welcome!'
puts 'Write the number of the option'
puts " 1. Job Title \n 2. Employer\'s name \n 3. City \n 4. Custom"
number = gets.chomp.to_i
scraper = Scraper.new
option(valid_option(number), scraper)

scraper.parse_url(scraper.create_link)

