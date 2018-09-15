class ProfilesController < ApplicationController
  layout 'main_table'
  before_action :authenticate_user, only: [:show, :edit, :update, :destroy]
  before_action :accept_user, only: [:new, :create]
  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
  end

  def edit
    @profile = Profile.find(params[:id])
    @user = @profile.user
  end

  def update
    @profile = Profile.find(params[:id])
    @user = @profile.user
    set_attribute

    user_valid = @user.valid?
    profile_valid = @profile.valid?

    if profile_valid && user_valid
      @user.save(validate: false)
      @profile.save(validate: false)
      redirect_to profile_path(@profile), notice: 'ユーザー情報を編集しました'
    else
      render :edit
    end
  end

  def new
    @user = @current_user
    @profile = @user.profile || Profile.new
    render layout: 'application'
  end

  def create
    @user = @current_user
    @user.build_profile if @user.profile.nil?
    @profile = @user.profile

    set_attribute

    user_valid = @user.valid?
    profile_valid = @profile.valid?

    if profile_valid && user_valid
      @user.save(validate: false)
      @profile.save(validate: false)
      session[:user_id] = @user.id
      redirect_to questions_path, notice: 'ユーザー情報を登録しました'
    else
      render :new
    end
  end

  private

  def set_attribute
    user_params = params.require(:user).permit(:name, :email)
    @user.attributes = user_params
    profile_params = params.require(:profile).permit(:grade, :school, :department, :lesson, :avatar, :interest_list)
    @profile.attributes = profile_params
  end
end
