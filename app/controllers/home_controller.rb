class HomeController < ApplicationController
  before_action :authenticate_user!
  skip_authorization_check

  def index

  	@user = current_user

    @my_challenges = @user.my_challenges
    @available_challenges = Challenge.active.where.not(@my_challenges)

  end
end
