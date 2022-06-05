class UsersController < ApplicationController
	skip_before_action :authenticate_request

	def new
	end

	def get
		email = params[:email]
		user = User.find_by(:email => email)
		if user
			response = user
		else
			response =  "Error: there is no user with such email"
		end
		render json: response
	end

	def create
		email = params[:email]
		password = params[:password]
		username = params[:username]
		user = User.find_by(:email => email)
		if user
			response = "Error: There is already a user with that email"
					
		else
			User.create(
				:email => email,
				:password => password,
				:password_confirmation => password,
				#:password_digest => password,
				:username => username,
				:history => []
			)
			user = User.find_by(:email => email)	
			if user
				response = "Success: User successfully registered"
			else
				response = "Error: There was an error in the backend registering the user"		
			end
		end
		render json: response
	end

	def destroy
	end
end
