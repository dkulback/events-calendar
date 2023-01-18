require 'rails_helper'

RSpec.describe 'shows/index', type: :feature do
  before(:each) do
    Show.create!(
      band: 'band name',
      doors: 'Door time',
      venue: 'Venue name'
    )
    Show.create!(
      band: 'band name',
      doors: 'Door time',
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
    save_and_open_page
    within '.notice' do
      expect(page).to have_content('Successfully scraped urls')
    end
  end
end
