class ApplicantsController < ApplicationController
  skip_authorization_check

  def index
  end

  def create
  	applicant = Applicant.new(params[:applicant])

    begin
  	 applicant.save!
     redirect_to request.referer, :notice => "#{applicant.email} has been added to the invite list!"
  	rescue  ActiveRecord::RecordInvalid => e
  		flash[:error] = e.message
      redirect_to request.referrer
  	end
  end

end