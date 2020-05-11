require 'byebug'
require 'nokogiri'
require 'rest-client'

class Scraper
  attr_accessor :form
  attr_reader :base_salary

  def initialize
    @form = ['', '', '', 'All+Years']
  end

  def create_link()
    link = "https://h1bdata.info/index.php?em=#{@form[0]}&job=#{@form[1]}&city=#{@form[2]}&year=#{@form[3]}"
    link.gsub!(/\s/, '+')
    link
  end

  def parse_url(link)
    parsed_page = Nokogiri::HTML(RestClient.get(link))
    parsed_page
    # byebug
  end
end

class Result
  attr_accessor :employer, :job_title, :base_salary, :location, :submit_date, :start_date

  def initialize
    @employer = ''
    @job_title = ''
    @base_salary = ''
    @location = ''
    @submit_date = ''
    @start_date = ''
  end

  def add_values(rows)
    @employer = rows.css('td')[0].text
    @job_title = rows.css('td')[1].text
    @base_salary = rows.css('td')[2].text
    @location = rows.css('td')[3].text
    @submit_date = rows.css('td')[4].text
    @start_date = rows.css('td')[5].text
  end
end
