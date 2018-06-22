class SessionsController < ApplicationController
  before_action :forbid_login_user, {only: [:new,:create]}

  def new
  end

  def index
  end

  def create
    pp params[:email]
    @user = User.find_by(email: params[:user][:email])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to questions_path
    else
      @error_message = "mアドレスが間違っています"
      render :new, email: params[:email]
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
end
