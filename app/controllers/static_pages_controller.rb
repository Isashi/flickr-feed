class StaticPagesController < ApplicationController
	require 'URI'

	def index
		@user = cookies[:logged_in_user]
	end

	def authorize
		flickr = FlickRaw::Flickr.new
		token = flickr.get_request_token(:oauth_callback => 'http://localhost:3000/callback')
		# You'll need to store the token somewhere for when the user is returned to the callback method
		# I stick mine in memcache with their session key as the cache key
		session[:token] = token

		@auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'read')
		# Stick @auth_url in your template for users to click
		
	end

	def callback
		user = FlickRaw::Flickr.new
		request_token = session[:token]
		oauth_token = params[:oauth_token]
		oauth_verifier = params[:oauth_verifier]
	
		raw_token = user.get_access_token(request_token['oauth_token'], request_token['oauth_token_secret'], oauth_verifier)

		oauth_token = raw_token['oauth_token']
		oauth_token_secret = raw_token['oauth_token_secret']

		user.access_token = oauth_token
		user.access_secret = oauth_token_secret

		cookies[:logged_in_user] = user
	end
end
