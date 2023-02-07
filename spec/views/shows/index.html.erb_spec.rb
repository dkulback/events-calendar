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
    within '.shows-data' do
      expect(page).to have_content('band name', count: 2)
      expect(page).to have_content('Door time', count: 2)
      expect(page).to have_content('Venue name', count: 2)
    end
  end
  xit 'has a button to scrape for shows' do
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
    scenario 'lets users search by venue name and date' do
      Show.create!(date: Date.today.yesterday, venue: 'Gothic')
      Show.create!(date: Date.today, venue: 'Bluebird')
      Show.create!(band: 'The Gories', date: Date.today, venue: 'Gothic')
      Show.create!(band: 'Metallica', date: Date.today.next_year.freeze, venue: 'Gothic')

      visit root_path
      within('//div[@class="flex items-center border-b border-teal-500 py-2"]') do
        select 'Gothic', from: 'search'

        fill_in :date_input, with: Date.today

        click_on 'Search'
      end
      expect(current_path).to eq(shows_path)
      within '.shows-data' do
        expect(page).to have_content('Gothic', count: 1)
        expect(page).to have_content('The Gories', count: 1)
        expect(page).to_not have_content('hi dive')
        expect(page).to_not have_content('Metallica')
        expect(page).to_not have_content('Bluebird')
      end
    end
    scenario 'when search is blank but a date is selected' do
      Show.create!(date: Date.today.yesterday, venue: 'Gothic')
      Show.create!(date: Date.today, venue: 'Bluebird')
      Show.create!(band: 'The Gories', date: Date.today, venue: 'Gothic')
      Show.create!(band: 'Metallica', date: Date.today.next_year.freeze, venue: 'Gothic')

      visit root_path
      within('//div[@class="flex items-center border-b border-teal-500 py-2"]') do
        fill_in :date_input, with: Date.today

        click_on 'Search'
      end
      expect(current_path).to eq(shows_path)
      within '.shows-data' do
        expect(page).to have_content('Gothic', count: 1)
        expect(page).to have_content('Bluebird', count: 1)
        expect(page).to have_content('The Gories', count: 1)

        expect(page).to_not have_content('hi dive')
        expect(page).to_not have_content('Metallica')
      end
    end
  end
end
