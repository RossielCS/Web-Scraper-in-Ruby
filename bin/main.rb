require_relative '../lib/scraper'
hash = { 0 => 'employer\'s name', 1 => 'job\'s title', 2 => 'city\'s name', 3 => 'year' }

def valid_option(number)
  until (0..4).include? number
    puts 'Please write a valid option'
    number = gets.chomp.to_i - 1
  end
  number
end

def option(number, obj, hash)
  puts "Write the #{hash[number]}"
  input = gets.chomp.strip
  input.gsub!(/[^\w]{1,}/, ' ')
  obj.form[number] = input =~ /\w/ ? input : ''
  puts "This is the value of #{hash[number]}: #{obj.form[number]}"
  puts "\n I'll proceed to do the search, it'll take a moment..."
end

def custom_options(obj, hash)
  puts " Now I'll aks you the value for each option, \n in case that there is an option
   that you don't want to write, just press 'enter'"
  obj.form.each_with_index do |_, y|
    puts "Write the #{hash[y]}"
    input = gets.chomp.strip
    input.gsub!(/[^\w]{1,}/, ' ')
    obj.form[y] = input =~ /\w/ ? input : ''
    obj.form[y] = input.gsub!(' ', '') if y == 3
  end
  puts "\n Good! These are the values \n Employer: #{obj.form[0]} \n Job's Title: #{obj.form[1]}
  City: #{obj.form[2]} \n Year: #{obj.form[3]}"
  puts "\n I'll proceed to do the search, it'll take a moment..."
end

puts 'Welcome!'
puts 'Write the number of the option'
puts " 1. Employer's name \n 2. Job's Title \n 3. City \n 4. Custom"
number = gets.chomp.to_i - 1

scraper = Scraper.new
valid_result = valid_option(number)

if valid_result < 3
  option(valid_result, scraper, hash)
else
  custom_options(scraper, hash)
end

scraper.parse_url(scraper.create_link)
