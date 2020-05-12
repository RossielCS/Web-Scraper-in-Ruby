# Web Scraper in Ruby
> This is a scraper build in Ruby.
I worked on this project as a requirement to finish the Ruby section in the Microverse Main Technical Curriculum.

To test the scrapper I decided to use the [H1B Salary Database](https://h1bdata.info/index.php) website.  
This site contains a database with the [Labor Condition Application](http://en.wikipedia.org/wiki/Labor_Condition_Application) from the [United States Department of Labor](http://www.foreignlaborcert.doleta.gov/performancedata.cfm#dis).

![screenshot](https://user-images.githubusercontent.com/60085697/81740340-359f3e80-9473-11ea-9c99-fc1f238d12a1.png)

## :hammer: Built With

- Ruby 2.6.5,
- Rubygems 3.0.3
- Nokogiri 1.10.9,
- Rest-client 2.1.0,
- Byebug 11.1.3,
- Rspec 3.9.0,
- Visual Code 1.44.2

## Getting Started

### :eyeglasses: What is web scraping?

According to [Wikipedia](https://en.wikipedia.org/wiki/Web_scraping)
> "...web harvesting, or web data extraction is data scraping used for extracting data from websites. Web scraping software may access the World Wide Web directly using the Hypertext Transfer Protocol, or through a web browser. While web scraping can be done manually by a software user, the term typically refers to automated processes implemented using a bot or web crawler."

To get a local copy up and running follow these simple example steps.

### Prerequisites
You need to install:
- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) language.
- [Rubygems](https://rubygems.org/pages/download).
- An IDE (Integrated Development Environment).

### Setup

1. Clone the repository.
2. In your OS terminal search the repository's address and run `bundle install`  
The command must install the gems required to run the program, such as:  
  [byebug](https://github.com/deivid-rodriguez/byebug)  
  [nokogiri](https://nokogiri.org/)  
  [rest-client](https://www.rubydoc.info/gems/rest-client/RestClient)  
  [rspec](https://rspec.info/)  

### :computer: Usage

- To run the program execute `ruby main.rb` from the bin folder.
- Follow the instructions.

### :pencil: Run tests
As a testing tool, I used [RSpec](https://en.wikipedia.org/wiki/RSpec).  
If you are interested in learning how it works, here is a link to [Introduction to RSpec](https://www.theodinproject.com/courses/ruby-programming/lessons/introduction-to-rspec) from The Odin Project.

- In the root folder, run `rspec` or `rspec --format documentation` to execute the tests.

## :gem: Features

- Has a user interface with instructions to follow.
- The user can choose what value provides to filter the search.
- It has an option to do a custom search.
- Displays the input provided by the user.
- If the search returns zero results it asks if the user wants to do another search.
- The user can discard the results.

## :woman: Author

**Rossiel Carranza**

- Github: [@RossielCS](https://github.com/RossielCS)
- Linkedin: [Rossiel Carranza](https://www.linkedin.com/in/rossiel-carranza-1666b11a1/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

## 📝 License

This project is [MIT](lic.url) licensed.