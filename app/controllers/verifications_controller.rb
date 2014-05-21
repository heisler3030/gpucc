class VerificationsController < ApplicationController
  skip_authorization_check

  before_filter {@blockscore = BlockScore::Client.new("ENV['BLOCKSCORE_KEY']"), version = 2)}

  def index
  	@verifications = @blockscore.get_verifications
  end
  
  def show
    @user = current_user
    @verification = @blockscore.get_verification(params[:id])
    puts("GOT VERIFICATION")
    puts @verification.inspect

  end

  def new
    puts("new verification")
    @user = current_user
  end
  
  def create
    puts("create verification")
    @user = current_user
    puts(params.inspect)

    @verification = params[:verification]
    @verification[:type] = "us_citizen"

    @myverification = @blockscore.create_verification(@verification)

  end

end
