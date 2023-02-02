require 'rails_helper'

RSpec.describe 'shows/index', type: :feature do
  before(:each) do
    Show.create!(
      band: 'band name',
      doors: 'Door time',
      date: Date.today,
      venue: 'Venue name'
    )
    Show.create!(
      band: 'band name',
      doors: 'Door time',
      date: Date.today,
      venue: 'Venue name'
    )
  end

  it 'renders a list of shows' do
    visit root_path
    expect(page).to have_content('band name', count: 2)
    expect(page).to have_content('Door time', count: 2)
    expect(page).to have_content('Venue name', count: 2)
  end
  it 'has a button to scrape for shows' do
    visit root_path

    within '.scrape-lar' do
      expect(page).to have_button('Scrape')
      click_on 'Scrape'
      expect(current_path).to eq(root_path)
    end
    within '.notice' do
      expect(page).to have_content('Successfully scraped urls')
    end
  end
  describe 'search form' do
    it 'lets users search by venue name' do
      Show.create!(date: Date.today.yesterday, venue: 'Gothic')
      Show.create!(date: Date.today, venue: 'Bluebird')
      Show.create!(date: Date.tomorrow, venue: 'hi dive')
      Show.create!(date: Date.today.next_year.freeze, venue: 'Gothic')

      visit root_path
      within('//div[@class="flex items-center border-b border-teal-500 py-2"]') do
        fill_in 'search', with: 'Gothic'

        click_on 'Search'
      end
      expect(current_path).to eq(shows_path)
      expect(page).to have_content('Gothic', count: 1)
      expect(page).to_not have_content('hi dive')
      expect(page).to_not have_content('Bluebird')
    end
  end
end
