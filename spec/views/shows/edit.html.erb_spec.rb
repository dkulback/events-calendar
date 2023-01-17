require 'rails_helper'

RSpec.describe "shows/edit", type: :view do
  let(:show) {
    Show.create!(
      band: "MyString",
      doors: "MyString",
      venue: "MyString"
    )
  }

  before(:each) do
    assign(:show, show)
  end

  it "renders the edit show form" do
    render

    assert_select "form[action=?][method=?]", show_path(show), "post" do

      assert_select "input[name=?]", "show[band]"

      assert_select "input[name=?]", "show[doors]"

      assert_select "input[name=?]", "show[venue]"
    end
  end
end
