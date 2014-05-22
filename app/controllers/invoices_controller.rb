class InvoicesController < ApplicationController
  skip_authorization_check

  @@API_URI = "https://bitpay.com"
  #@@API_URI = "https://test.bitpay.com"

  before_filter :get_client

  def get_client
  	@client = BitPay::Client.new(ENV["BITPAY_KEY"], {api_uri: @@API_URI})
  end

  def index
  	#@invoices = @client.get 'invoices'
  	# Seems like get invoices is having problems
  	@invoices = nil
  end

  def new
  	@user = current_user
  	@currencies = (@client.get 'currencies')["data"]

  end

  def create
  	puts "ABOUT TO POST INVOICE"
  	puts params[:invoice]
  	# This isn't particularly secure but ok for POC
  	#@invoice = @client.post 'invoice', params[:invoice]

  	price = params[:invoice][:price]
  	currency = params[:invoice][:currency]

	#@invoice = @client.post 'invoice', {:price => price.to_f, :currency => currency}

	@invoice = @client.post 'invoice', {:price => 10.00, :currency => 'USD'}

  	puts "INVOICE RESPONSE:"
  	puts @invoice.inspect

  end

  def show
  	@invoice = nil
  	#@invoice = @client.get 'invoice', params[:id]
  end

end