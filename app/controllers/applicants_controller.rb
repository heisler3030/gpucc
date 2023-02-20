class ApplicantsController < ApplicationController
  load_and_authorize_resource

  def index
    @applicants = Applicant.all
    @pending_invites = User.invited
  end

  def create
  	applicant = Applicant.new(applicant_params)

    begin
  	 applicant.save!
     redirect_to request.referer, :notice => "#{applicant.email} has been added to the invite list!"
  	rescue  ActiveRecord::RecordInvalid => e
  		flash[:error] = e.message
      redirect_to request.referrer
  	end
  end

private
  def applicant_params
    params.require(:applicant).permit(:email)
  end
end