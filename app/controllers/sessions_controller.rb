class SessionsController < ApplicationController
  # before_action :forbid_login_user, {only: [:new,:create]}

  def new
  end

  def index
  end

  def create
    @user = User.find_by(name: params[:name], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to users_path
    else
      @error_message = "ユーザー名またはパスワードが間違っています"
      render new_session_path, name:params[:name]
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to new_session_path
  end
end
