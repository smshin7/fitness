class UsersController < ApplicationController
	before_action :authorize, except: [:new, :create]

	def index
		@users = User.where(user: @user).all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
	
		if @user.save
			flash.now[:info] = "New User Created"
			redirect_to @user
		else
			flash.now[:danger] = @user.errors.full_messages.to_sentence
			render :new
		end
	end

	def edit
		get_user
	end

	def update
			@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to @user
		else
			render :edit
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to @user
	end

	def get_user
		@user = User.find(params[:id])
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :age, :gender, :email, :height, :weight, :location, :profile_pic, :goal, :password, :password_confirmation)
	end

end