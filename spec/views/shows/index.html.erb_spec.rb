require 'rails_helper'

RSpec.describe "shows/index", type: :view do
  before(:each) do
    assign(:shows, [
      Show.create!(
        band: "Band",
        doors: "Doors",
        venue: "Venue"
      ),
      Show.create!(
        band: "Band",
        doors: "Doors",
        venue: "Venue"
      )
    ])
  end

  it "renders a list of shows" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Band".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Doors".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Venue".to_s), count: 2
  end
end
