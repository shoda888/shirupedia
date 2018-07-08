class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
    @users = @users.map do |user|
      {
          id: user.id,
          name: user.name,
          email: user.email
      }
    end
    render json: @users
  end

  def create
    User.new()
    save
    render json: {staus: 400}
    render
  end

  def show
  end

  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     session[:user_id] = @user.id
  #     flash[:notice] = "ユーザーが登録されました"
  #     redirect_to new_profile_path
  #   else
  #     render :new
  #   end
  # end
  private

  def user_params
    params.require(:user).permit(:email)
  end
end
