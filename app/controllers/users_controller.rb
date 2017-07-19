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
    	if (params[:fullname] != nil)
    	 current_user.nickname = params[:fullname]
    	 current_user.save
    	 redirect_to users_path	
    	end	
	end
end