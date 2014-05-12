class HomeController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check

  def index

  	@user = current_user
  	@my_challenge_assignments = @user.challenge_assignments

    # Have to throw an extra fake element in the array in case there are no challenge assignments for this user,
    # so the query below doesn't fail
    challenge_assignment_list = @my_challenge_assignments.map(&:challenge_id).push(-1)

    @my_challenges = Challenge.find(:all, :conditions => {:id => (challenge_assignment_list)})
    @available_challenges = Challenge.find(:all, :conditions => ['id not in (?)', (challenge_assignment_list)])

  end
end
