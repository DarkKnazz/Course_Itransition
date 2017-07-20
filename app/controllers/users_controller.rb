class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]

	def index
		@users = User.all
	end

	def show
		if(current_user != nil)
		  if(@user.id == current_user.id)
		  	redirect_to edit_user_path
		  end
		end
	end

	def edit
		if @user.id != current_user.id
			redirect_to root_path
		end
	end

	def update
    	respond_to do |format|
      	  if @user.update(user_params)
        	format.html { redirect_to @user, notice: 'User was successfully updated.' }
        	format.json { render :show, status: :ok, location: @user }
      	  else
        	format.html { render :edit }
        	format.json { render json: @user.errors, status: :unprocessable_entity }
      	  end
    	end
	end

	def set_user
      @user = User.find(params[:id])
    end

	def user_params
      params.require(:user).permit(:nickname, :email, :about)
    end
end