require 'rails_helper'

RSpec.describe Show, type: :model do
  describe '::by_date' do
    it 'lets the shows by the date header' do
      show0 = Show.create!(date: Date.yesterday)
      show1 = Show.create!(date: Date.today)
      show2 = Show.create!(date: Date.tomorrow)
      show3 = Show.create!(date: '31 Jan'.to_date)
      actual = Show.by_date
      expected = [show1, show2, show3]
      expect(actual).to eq(expected)
    end
  end
  describe '::search' do
    it 'lets the shows by the date header and venue search param' do
      show0 = Show.create!(date: Date.yesterday, venue: 'Gothic')
      show1 = Show.create!(date: Date.today, venue: 'Bluebird')
      show2 = Show.create!(date: Date.tomorrow, venue: 'hi dive')
      show3 = Show.create!(date: '31 Jan'.to_date.freeze, venue: 'Gothic')
      actual = Show.search('gothic')
      expected = [show3]
      expect(actual).to eq(expected)
    end
  end
end
