require_relative '../lib/scraper'
def valid_option(number)
  until (1..4).include? number
    puts 'Please write a valid option'
    number = gets.chomp.to_i
  end
  puts number
end

puts 'Welcome!'
puts 'Write the number of the option'
puts " 1. Job Title \n 2. Employer \n 3. City \n 4. Custom"
number = gets.chomp.to_i
scraper = Scraper.new
valid_option(number)
