class StaticPagesController < ApplicationController
	def index
		@user = JSON.parse(cookies[:logged_in_user]) if cookies[:logged_in_user]
		binding.pry
	end
end
