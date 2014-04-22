class HomeController < ApplicationController
  before_filter :authenticate_user!
  skip_authorization_check

  def index

    challenge_assignment_list = current_user.challenge_assignments.map(&:challenge_id).push(-1)

    # Have to throw an extra fake element in the array in case there are no challenge assignments for this user
    @my_challenges = Challenge.find(:all, :conditions => {:id => (challenge_assignment_list)})
    @available_challenges = Challenge.find(:all, :conditions => ['id not in (?)', (challenge_assignment_list)])

  end
end
