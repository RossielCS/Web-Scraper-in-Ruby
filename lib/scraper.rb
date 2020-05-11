require 'byebug'
require 'nokogiri'
require 'rest-client'

class Scraper
  attr_accessor :job, :employer, :city, :year, :link

  def initialize(job = '&', employer = '&', city = '&', year = 'All+Years')
    @job = job
    @employer = employer
    @city = city
    @year = year
    @base_salary = ''
  end

  def create_link()
    link = "https://h1bdata.info/index.php?em=#{@employer}job=#{@job}city=#{@city}year=#{@year}".sub(' ', '+')
    link
  end

  def parse_url(link)
    parsed_page = Nokogiri::HTML(RestClient.get(link))
    parsed_page
    byebug
  end
end
