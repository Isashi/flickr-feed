class SessionsController < ApplicationController
  def authorize
		flickr = FlickRaw::Flickr.new
		token = flickr.get_request_token(:oauth_callback => 'http://localhost:3000/callback')
		session[:token] = token
		@auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'read')
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

    sesh = {}
    sesh[:request_token] = request_token
    sesh[:oauth_verifier] = oauth_verifier
    sesh[:raw_token] = raw_token

    cookies[:logged_in_user] = JSON.generate(sesh)
	end
end
