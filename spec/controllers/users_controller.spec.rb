require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { FactoryBot.create(:user) }

  describe "GET #profile" do
    context "when user is signed in" do
      before do
        sign_in user
        get :profile
      end

      it "renders the profile template" do
        expect(response).to render_template(:profile)
      end

      it "returns a successful response (200 OK)" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "when user is not signed in" do
      before do
        get :profile
      end

      it "redirects to the login page" do
        expect(response).to redirect_to(new_user_session_path)
      end

      it "sets a flash message" do
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end