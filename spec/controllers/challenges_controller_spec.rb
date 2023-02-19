require 'spec_helper'

describe ChallengesController do

  before :each do
    @user = create(:test_user)
  end

  describe "index" do
  
    describe "Unauthenticated GET" do
      it "should be redirect" do
        get 'index'
        expect(response).to be_redirect
      end
    end
  
    describe "Authenticated GET" do
      it "should be success" do
        sign_in @user
        get 'index'
        expect(response).to be_successful
      end
    end
  
    it "should assign my_challenges" do
      5.times {create(:challenge)}
      ca1 = create(:challenge_assignment, user: @user)
      ca2 = create(:challenge_assignment, user: @user)
      sign_in @user
      get :index
      expect(assigns(:my_challenges)).to match_array [ca1.challenge, ca2.challenge]
    end

    it "should assign available_challenges" do
      5.times {create(:challenge)}
      ca1 = create(:challenge_assignment, user: @user)
      ca2 = create(:challenge_assignment, user: @user)
      sign_in @user
      get :index
      expect(assigns(:available_challenges).size).to eq(5)
    end

  end
  
  describe "show" do
    it "should show the current workouts for an assigned user"
    it "should include future workouts for the challenge owner"
    it "should show the future workouts for an admin"
  end

end
