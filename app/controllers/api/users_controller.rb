class Api::UsersController < Api::ApplicationController
  before_action :auth, except: [:signin, :signup]

  def index
    @users = User.all
    # @users = @users.map do |user|
    #   {
    #     id: user.id,
    #     name: user.name,
    #     email: user.email
    #   }
    # end
    render json: @users
  end

  ## サインアップ
  def signup
  end

  ## サインイン
  def signin
  end

  def create
    # @user = User.new(user_params)
    # if @user.valid?
    #   @user.save
    #   # http://localhost:1080/でメール確認
    #   UserMailer.created_with_email(@user).deliver_now
    #   session[:requested] = @user.id
    #   head :no_content
    # else
    #   render :new
    # end
  end

  def show
    @user = User.find(params[:id])
    render json: @user
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
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
