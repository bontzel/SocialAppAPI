class SessionsController < ApplicationController
	
	def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
			respond_to do |format|
				msg = { :statusKey => 0, :message => "Login succsessful!", :user => user }
				format.json  { render :json => msg } # don't do msg.to_json
			end
    else
			respond_to do |format|
				self.status = 422
				msg = { :statusKey => 0, :message => "Invalid username or password", :user => user }
				format.json  { render :json => msg } # don't do msg.to_json
			end
    end
  end
	
end
