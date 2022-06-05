class SessionsController < ApplicationController
	skip_before_action :authenticate_request
	def new
	end

	def history
		params.permit(:email, :history => [])
		email = params[:email]		
		history =  params[:history]#.split(",")
		user = User.find_by(:email => email)
		if user
			user.update_attribute(:history, history)
			puts params[:history]
			# user.history = params[:history]
			response = {
				:history => "Success: history updated"
			}
		else
			response = {
				:history => "Error: history couldn't be created"
			}			
		end
		render json: response
	end

	def notifications
		#params.permit(:email, :notifications => [])
		email = params[:email]		
		notifications =  params[:notifications]#.split(",")
		user = User.find_by(:email => email)
		if user
			user.update_attribute(:notifications, notifications)
			puts params[:notifications]
			# user.history = params[:history]
			response = {
				:notifications => "Success: notifications updated"
			}
		else
			response = {
				:notifications => "Error: notifications couldn't be created"
			}			
		end
		render json: response
	end

	def create
#		email = params[:email]
#		password = params[:password]
		userFound = User.find_by(:email => params[:email])
#		if user && user.password_digest == password
#			response = user
#		else
#			response = "Error: user not found"
#		
#		end
#		render json: response
		command = AuthenticateUser.call(params[:email], params[:password])

		if command.success?
			userInfo = {
				:user => userFound,
				:auth_token => command.result
			}
		  render json: userInfo
		  #render json: { auth_token: command.result }
		else
		  render json: { error: command.errors }, status: :unauthorized
		end
	end

	def destroy
	end
end
