require 'spec_helper'

describe HomeController do

  describe "Unauthenticated GET 'index'" do
    it "should be redirect" do
      get 'index'
      response.should be_redirect
    end
  end

  describe "Authenticated GET 'index'" do
    it "should be success" do
      user = create(:test_user)
      sign_in user
      get 'index'
      response.should be_success
    end
  end

end
