class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      # http://localhost:1080/でメール確認
      UserMailer.created_with_email(@user, @user.token).deliver_now
      head :no_content
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
