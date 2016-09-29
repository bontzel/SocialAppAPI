class UsersController < ApplicationController
	
	
	def create
		user = User.new
		
		user.email = params[:email]
		user.password = params[:password]
		user.password_confirmation = params[:password_confirmation]
		
		
		if User.exists?(:email => params[:email])
			respond_to do |format|
				self.status = 409
				msg = { :statusKey => 0, :message => "User email already taken!" }
				format.json  { render :json => msg } # don't do msg.to_json
			end
		elsif user.save(:validate => false)
			respond_to do |format|
				msg = { :status => "ok", :message => "Success!", :user => user }
				format.json  { render :json => msg } # don't do msg.to_json
			end
  	elsif
			respond_to do |format|
				msg = { :status => "notOk", :message => "Failed!" }
				format.json  { render :json => msg } # don't do msg.to_json
			end
		end
	end
	
	
	
end
