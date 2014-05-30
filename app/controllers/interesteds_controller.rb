class InterestedsController < ApplicationController
  skip_authorization_check

  def create
	puts("deres dem params")
  	puts(params.inspect)
  	applicant = Interested.new(params[:interested])

  	if applicant.save!
  		redirect_to request.referer, :notice => "#{applicant.email} has been added to the invite list!"
  	else
  		redirect_to request.referrer, :error => "Error Found!"
  	end
  end


end