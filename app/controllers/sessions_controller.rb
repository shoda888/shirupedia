class SessionsController < ApplicationController
  before_action :forbid_login_user, {only: [:new,:create]}

  def new
  end

  def index
  end

  def create
    @user = User.find_by(email: params[:email])
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
    redirect_to new_session_path
  end
end
