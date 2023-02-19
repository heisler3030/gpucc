class HomeController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check

  def index
  	@user = current_user
    @my_challenges = @user.challenges
    @available_challenges = Challenge.active - @my_challenges
  end
end
