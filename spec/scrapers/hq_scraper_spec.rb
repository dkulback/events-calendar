require 'rails_helper'

RSpec.describe HqScraper, type: 'Scraper' do
  let(:scraper) { HqScraper }
  describe '::shows' do
    it 'gathers show data' do
      data = scraper.shows
      expect(data).to be_a Array
      data.each do |d|
        expect(d).to have_key(:band)
        expect(d).to have_key(:date)
        expect(d).to have_key(:venue)
        expect(d).to have_key(:doors)
        expect(d).to have_key(:tickets)
      end
    end
  end
end
