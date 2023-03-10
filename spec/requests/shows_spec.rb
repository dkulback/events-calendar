require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/shows", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Show. As you add validations to Show, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Show.create! valid_attributes
      get shows_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      show = Show.create! valid_attributes
      get show_url(show)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_show_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      show = Show.create! valid_attributes
      get edit_show_url(show)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Show" do
        expect {
          post shows_url, params: { show: valid_attributes }
        }.to change(Show, :count).by(1)
      end

      it "redirects to the created show" do
        post shows_url, params: { show: valid_attributes }
        expect(response).to redirect_to(show_url(Show.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Show" do
        expect {
          post shows_url, params: { show: invalid_attributes }
        }.to change(Show, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post shows_url, params: { show: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested show" do
        show = Show.create! valid_attributes
        patch show_url(show), params: { show: new_attributes }
        show.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the show" do
        show = Show.create! valid_attributes
        patch show_url(show), params: { show: new_attributes }
        show.reload
        expect(response).to redirect_to(show_url(show))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        show = Show.create! valid_attributes
        patch show_url(show), params: { show: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested show" do
      show = Show.create! valid_attributes
      expect {
        delete show_url(show)
      }.to change(Show, :count).by(-1)
    end

    it "redirects to the shows list" do
      show = Show.create! valid_attributes
      delete show_url(show)
      expect(response).to redirect_to(shows_url)
    end
  end
end
