require_relative '../lib/result'
require 'nokogiri'
require 'rest-client'

describe Result do
  subject(:result) { Result.new }
  let(:link) { 'https://h1bdata.info/index.php?em=airbnb&job=software+engineer&city=seattle&year=2017' }
  let(:url) { Nokogiri::HTML(RestClient.get(link)).css('tbody').css('tr') }

  describe '#add_values' do
    it 'changes instance variables default values with the passed argument' do
      result.add_values(url[0])
      expect(result.instance_variable_get(:@employer)).to eq('AIRBNB INC')
      expect(result.instance_variable_get(:@job_title)).to eq('SOFTWARE ENGINEER')
      expect(result.instance_variable_get(:@base_salary)).to eq('122,000')
      expect(result.instance_variable_get(:@location)).to eq('SEATTLE, WA')
      expect(result.instance_variable_get(:@submit_date)).to eq('02/18/2017')
      expect(result.instance_variable_get(:@start_date)).to eq('08/01/2017')
    end
  end
end
