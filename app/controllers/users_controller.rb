class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		if(current_user != nil)
		  if(@user.id == current_user.id)
		  	redirect_to users_update_path
		  end
		end
	end

	def update
    	 current_user.nickname = params[:nickname] if params[:nickname]
    	 current_user.email = params[:email] if params[:email]
    	 current_user.about = params[:about] if params[:about]
    	 current_user.save	
	end
end