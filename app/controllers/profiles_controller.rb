class ProfilesController < ApplicationController
  def new
    @user = @current_user
    @profile = @user.profile || Profile.new
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
      redirect_to questions_path, notice: 'ユーザー情報を登録しました'
    else
      render :new
    end
  end
  private

  def set_attribute
    user_params = params.require(:user).permit(:name, :email)
    @user.attributes = user_params
    profile_params = params.require(:profile).permit(:grade, :department, :lesson)
    @profile.attributes = profile_params
  end
end
