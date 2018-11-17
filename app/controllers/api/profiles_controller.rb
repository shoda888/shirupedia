class Api::ProfilesController < Api::ApplicationController
  before_action :auth

  def create
    @user = @current_user
    @user.build_profile if @user.profile.nil?
    @profile = @user.profile

    set_attribute

    user_valid = @user.valid?
    profile_valid = @profile.valid?

    if profile_valid && user_valid
      @user.token = SecureRandom.hex(12)
      @user.save(validate: false)
      @profile.save(validate: false)
      session[:user_id] = @user.id
      response_success('profile', 'create')
    else
      response_bad_request
    end
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
      response_success('profile', 'update')
    else
      response_bad_request
    end
  end

  private

  def set_attribute
    user_params = params.permit(:name, :email, :password, :password_confirmation)
    @user.attributes = user_params
    profile_params = params.permit(:grade, :school, :department, :lesson, :avatar, :interest_list)
    @profile.attributes = profile_params
  end
end
