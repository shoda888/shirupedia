class SessionsController < ApplicationController
  before_action :forbid_login_user, { only: [:new, :create] }

  def new
  end

  def index
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to questions_path
    else
      flash[:notice] = "ログイン情報が間違っています"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end
end
