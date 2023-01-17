require 'rails_helper'

RSpec.describe "shows/new", type: :view do
  before(:each) do
    assign(:show, Show.new(
      band: "MyString",
      doors: "MyString",
      venue: "MyString"
    ))
  end

  it "renders new show form" do
    render

    assert_select "form[action=?][method=?]", shows_path, "post" do

      assert_select "input[name=?]", "show[band]"

      assert_select "input[name=?]", "show[doors]"

      assert_select "input[name=?]", "show[venue]"
    end
  end
end
