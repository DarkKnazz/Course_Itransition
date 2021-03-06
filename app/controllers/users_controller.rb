class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:edit, :update, :destroy]

	def index
		@users = User.all
	end

	def show
		@posts = @user.posts
	end

	def edit
		secureUser @user
	end

	def update
		secureUser @user
    respond_to do |format|
    	if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
		secureUser @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

	private
		def secureUser user
			if user.id != current_user.id && current_user.isAdmin == false
				redirect_to root_path
			end
		end

		def set_user
	    @user = User.find(params[:id])
	  end

		def user_params
	    params.require(:user).permit(:nickname, :email, :about)
	  end
end
