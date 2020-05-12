require_relative '../lib/scraper'

describe Scraper do
  subject(:scraper) { Scraper.new }
  let(:link) { 'https://h1bdata.info/index.php?em=&job=&city=&year=All+Years' }
  describe '#create_link' do
    it 'returns a link by using passed values to the variable form and adding a \'+\ between spaces' do
      scraper.form[0] = 'airbnb'
      scraper.form[1] = 'software engineer'
      scraper.form[2] = 'seattle'
      scraper.form[3] = '2017'
      expect(scraper.create_link).to eql('https://h1bdata.info/index.php?em=airbnb&job=software+engineer&city=seattle&year=2017')
    end

    it 'returns a link with form default values' do
      expect(scraper.create_link).to eql('https://h1bdata.info/index.php?em=&job=&city=&year=All+Years')
    end
  end

  describe '#parse_url' do
    it 'returns a parsed page using the link passed as an argument' do
      expect(scraper.parse_url(link)).to be_an_instance_of(Nokogiri::HTML::Document)
    end
  end
end
