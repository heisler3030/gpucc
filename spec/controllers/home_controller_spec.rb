require 'spec_helper'

describe HomeController do

  describe "Unauthenticated GET 'index'" do
    it "should be redirect" do
      get 'index'
      response.should be_redirect
    end
  end

  describe "Authenticated GET 'index'" do
    xit "should be success" do
      # set current_user to :user
      
      get 'index'
      response.should be_success
    end
  end

end
