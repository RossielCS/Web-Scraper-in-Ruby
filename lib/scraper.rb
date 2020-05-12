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
  end
end
