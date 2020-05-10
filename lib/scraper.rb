require 'byebug'
require 'nokogiri'
require 'rest-client'

class Scraper
  def initialize(job = '&', employer = '&', city = '&', year = 'All+Years')
    @job = job
    @employer = employer
    @city = city
    @year = year
    @base_salary = ''
    @link = "https://h1bdata.info/index.php?em=#{@employer}job=#{@job}city=#{@city}year=#{@year}".sub(' ', '+')
  end

  def parse_url
    # unparsed_page = RestClient.get(@link)
    parsed_page = Nokogiri::HTML(RestClient.get(@link))
    parsed_page
    # byebug
  end
end
