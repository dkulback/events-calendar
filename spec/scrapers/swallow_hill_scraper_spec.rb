require 'rails_helper'

RSpec.describe SwallowHillScraper do
  let(:scraper) { SwallowHillScraper }

  describe '#scrape' do
    it 'returns an array of events' do
      stub_request(:get, 'https://swallowhillmusic.org/concerts/').to_return(
        status: 200,
        body: File.read('spec/fixtures/swallow.html')
      )
      events = scraper.shows
      expect(events).to be_an(Array)
      events.each do |event|
        expect(event).to be_a(Hash)
        expect(event[:band]).to be_a(String)
        expect(event[:date]).to be_a(Date)
        expect(event[:venue]).to be_a(String)
        expect(event[:doors]).to be_a(String)
        expect(event[:tickets]).to be_a(String)
      end
    end
  end
end
