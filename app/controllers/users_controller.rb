class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザーが登録されました"
      redirect_to new_profile_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
