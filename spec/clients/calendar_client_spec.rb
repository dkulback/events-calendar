require 'rails_helper'

RSpec.describe CalendarClient do
  describe '#insert_event' do
    it 'inserts an event' do
      response = File.open('spec/fixtures/insert_event/success.json')
      stub_request(:post, 'https://www.googleapis.com/calendar/v3/calendars/primary/events')
        .to_return(status: 200, body: response)
      client = CalendarClient
      token = '12345'
      event = Show.new(band: 'The Band', venue: 'The Venue', date: Date.today)

      actual = client.insert_event(token, event)

      expect(actual).to be_a(Hash)
      expect(actual).to have_key('id')
      expect(actual).to have_key('summary')
      expect(actual).to have_key('start')
      expect(actual).to have_key('kind')
      expect(actual).to have_key('etag')
      expect(actual).to have_key('status')
      expect(actual).to have_key('description')
    end
  end
end
