class HomeController < ApplicationController
  def index
    @users = User.all
    @groups = Group.all

    if user_signed_in?
     if current_user.profile
		@profile = Profile.find(current_user.profile)
end
    end
  end