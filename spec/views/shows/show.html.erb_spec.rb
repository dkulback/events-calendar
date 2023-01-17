require 'rails_helper'

RSpec.describe "shows/show", type: :view do
  before(:each) do
    assign(:show, Show.create!(
      band: "Band",
      doors: "Doors",
      venue: "Venue"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Band/)
    expect(rendered).to match(/Doors/)
    expect(rendered).to match(/Venue/)
  end
end
