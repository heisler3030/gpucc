class PagesController < ApplicationController
  skip_authorization_check

  def verification
  	@user = User.find_by_id(params[:user])

  	@blockscore = BlockScore::Client.new("ENV['BLOCKSCORE_KEY']", version = 2)

	@myverification = @blockscore.create_verification({
	  type: "us_citizen",
	  date_of_birth: "1993-08-23",
	  identification: {
	    ssn: "0000"
	  },
	  name: {
	    first: "Alain",
	    middle: nil,
	    last: "Meier"
	  },
	  address: {
	    street1: "1 Infinite Loop",
	    street2: nil,
	    city: "Cupertino",
	    state: "CA",
	    postal_code: "95014",
	    country: "US"
	  }
	})

  end

end