require 'net/ldap'

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
		email = params[:email]
		puts email
		password = params[:password]
		puts password
		ldap      = Net::LDAP.new
		ldap.host = LDAP_CONFIG['host']
		puts ldap.host
		ldap.port = LDAP_CONFIG['port']
		puts ldap.port
		ldap.authenticate "cn=#{email},ou=sa,dc=arqsoft,dc=unal,dc=edu,dc=co", password
		bound = ldap.bind
	
		if bound
			puts "Got it"
		else
			render json: error= {
				:error => "Error: user is not in organization (LDAP)"
			}
			return ""
		end

		userFound = User.find_by(:email => params[:email])
		command = AuthenticateUser.call(params[:email], params[:password])

		if command.success?
			userInfo = {
				:user => userFound,
				:auth_token => command.result
			}
		  render json: userInfo
		  #render json: { auth_token: command.result }
		else
			render json: error= {
				:error => "Error: invalid credentials"
			}
		  #render json: { error: command.errors }, status: :unauthorized
		end
	end

	def destroy
	end
end
