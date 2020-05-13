require_relative '../lib/scraper'
require_relative '../lib/result'
require 'paint'

hash = { 0 => 'employer\'s name', 1 => 'job title', 2 => 'city\'s name', 3 => 'year between 2012 and 2020' }
instructions = Paint['The value can be alphanumeric and have just one space between words.
Using any other characters possibly will bring', :cyan] + Paint[' zero results', :magenta] + Paint[".\n", :cyan]
all_results = []
rewrite = Paint['Please write a valid option', :red]
file_num = 0

# Verify the input for the four main options
def valid_option(number, rewrite)
  until (0..4).include? number
    puts rewrite
    number = gets.chomp.to_i - 1
  end
  number
end

# Calls methods depending on the value of valid_result
def name_year(scraper, valid_result, hash, instructions)
  if valid_result < 3
    input_name(valid_result, scraper, hash, instructions)
  else
    count = 0
    loop do
      input_name(count, scraper, hash, instructions)
      count += 1
      break if count == 3
    end
    input_year(scraper, hash)
  end
end

# Saves the input in the instance variable form
def input_name(number, obj, hash, instructions)
  puts(Paint["\n  Write the ", :cyan] + Paint[hash[number].to_s, :magenta] + Paint[' or press ', :cyan] +
  Paint['enter', :magenta] + Paint['.', :cyan])
  puts instructions
  input = gets.strip
  obj.form[number] = input =~ /\w/ ? input : ''
end

# Saves the input in the instance variable form as the year
def input_year(obj, hash)
  puts(Paint["\n  Write the ", :cyan] + Paint[hash[3].to_s, :magenta] + Paint[' or press ', :cyan] +
    Paint['enter', :magenta] + Paint[".\n", :cyan])
  input = gets.strip
  obj.form[3] = input =~ /\d/ ? input : obj.form[3]
end

# Displays all the input provided by the user
def display_input(scraper)
  puts Paint["\n  Good! These are the values", :cyan]
  puts(Paint["\n    Employer: ", :cyan] + Paint[scraper.form[0].to_s, :magenta] + Paint["\n    Job Title: ", :cyan] +
 Paint[scraper.form[1].to_s, :magenta] + Paint["\n    City: ", :cyan] +
 Paint[scraper.form[2].to_s, :magenta] + Paint["\n    Year: ", :cyan] +
 Paint[scraper.form[3].to_s, :magenta])
end

# The user selects to save the search results or to discard them
def display_discard(findings, url, all_results, rewrite)
  loop do
    answer = gets.chomp
    if answer == 'y'
      save_results(findings, url, all_results)
      return answer
    elsif answer == 'n'
      all_results.clear
      break
    else
      puts rewrite
    end
  end
end

# Add values to Result instances and add them to all_results
def save_results(findings, url, all_results)
  findings.times do |idx|
    obj = Result.new
    obj.add_values(url[idx])
    all_results << obj
  end
end

# Displays the values of each Result instance
def display_values(all_results)
  all_results.each_with_index do |x, y|
    puts(Paint["\n    Result number: ", :cyan] + Paint[(y + 1).to_s, :yellow] +
    Paint["\n    Employer: ", :green] + Paint[x.employer.to_s, :magenta] + Paint["\n    Job Title: ", :green] +
    Paint[x.job_title.to_s, :magenta] + Paint["\n    Base Salary: ", :green] + Paint[x.base_salary.to_s, :magenta] +
    Paint["\n    Location: ", :green] + Paint[x.location.to_s, :magenta] + Paint["\n    Submit Date: ", :green] +
    Paint[x.submit_date.to_s, :magenta] + Paint["\n    Start Date: ", :green] + Paint[x.start_date.to_s, :magenta])
  end
end

# Asks if the user wants to save the results
def save_or_not(all_results, file_num)
  puts(Paint["\n  Would you like to save the results? ", :cyan] + Paint['y', :magenta] +
    Paint[' to save or ', :cyan] + Paint['n', :magenta] + Paint[" to not and continue.\n", :cyan])
  loop do
    input = gets.chomp
    return save_search_in_file(all_results, file_num) if input == 'y'
    break if input == 'n'

    puts rewrite
  end
end

# This method saves the results in a text file
def save_search_in_file(all_results, file_num)
  puts Paint["\n  I'll proceed to save the search results in a text file...", :green]
  file_num += 1
  file = File.new("Search Number: #{file_num}", 'w')
  all_results.each_with_index do |x, y|
    file.puts("\nResult number: #{y + 1}
    Employer: #{x.employer}" + "\n    Job Title: #{x.job_title}
    Base Salary: #{x.base_salary}" + "\n    Location: #{x.location}
    Submit Date: #{x.submit_date}" + "\n    Start Date: #{x.start_date}")
  end
  file.close
  puts(Paint['  Done! now you can access to it inside the', :green] +
  Paint[' bin ', :magenta] + Paint['folder.', :green])
  file_num
end

# This method closes the program or let restart the main loop
def close_scraper(rewrite, all_results)
  puts(Paint["\n  Would you like to do another search? ", :cyan] + Paint['y', :magenta] +
  Paint[' to continue ', :cyan] + Paint['n', :magenta] + Paint[" to exit.\n", :cyan])
  loop do
    final = gets.chomp
    if final == 'y'
      all_results.clear
      puts Paint["\n  Ok, let\'s start again!", :cyan]
      break
    elsif final == 'n'
      puts "\n" + Paint['     Ok, see you later!     '.center(80, '* * '), :cyan] + "\n\n"
      exit
    else
      puts rewrite
    end
  end
end

puts "\n\n\n" + Paint['     Welcome!     '.center(80, '* * '), :green, :bold]
puts(Paint["\n With this web scraper, you can search information about the salaries for
applicants to the United States visa H1B.\n
  All the information it's obtained from the website H1B Salary Database ", :cyan] +
  Paint["\nh1bdata.info", :magenta] + Paint['.', :cyan] +
  Paint["\nIn case you\'re interested in what you\'ve found here, please visit the website.
  \n  To do the search it\'s necessary to apply at least one of these filters:", :cyan])
puts Paint["\n    * Employer \n    * Job title \n    * City \n ", :magenta]
puts(Paint['  By default, the scrapper does the search including all the available years,
  which are from', :cyan] + Paint[' 2012 ', :magenta] + Paint['to', :cyan] + Paint[' 2020', :magenta] +
  Paint['.', :cyan])

# Main loop
loop do
  puts(Paint["\n\n  Please write the number of the option.
  In case you want to add more that one filter,
you can choose the", :cyan] + Paint[' custom ', :magenta] +
  Paint['option to add value to any filter, even the year.', :cyan])
  puts Paint["\n    (1) Employer's Name \n    (2) Job Title \n    (3) City's Name \n    (4) Custom\n", :magenta]
  number = gets.chomp.to_i - 1
  scraper = Scraper.new
  valid_result = valid_option(number, rewrite)
  name_year(scraper, valid_result, hash, instructions)

  display_input(scraper)
  puts Paint["\n  I'll proceed to do the search, it'll take a moment...", :green]

  url = scraper.parse_url(scraper.create_link).css('tbody').css('tr')
  findings = url.count

  puts(Paint['  The search returned ', :green] + Paint[findings.to_s, :magenta] +
  Paint[' results.', :green])
  if findings.positive?
    puts(Paint["\n  Do you want to display all results? ", :cyan] + Paint['y', :magenta] +
    Paint[' or ', :cyan] + Paint['n', :magenta] + Paint[" to discard and continue.\n", :cyan])
    display = display_discard(findings, url, all_results, rewrite)
    if display == 'y'
      display_values(all_results)
      file_num = save_or_not(all_results, file_num)
    end
  end
  close_scraper(rewrite, all_results)
end
