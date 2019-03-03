class Api::ProfilesController < Api::ApplicationController
  before_action :auth
  before_action :find_profile, only: [:answered, :questioned, :update]

  def answered
    @questions = @user.answeredquestions.includes([:fields, user: :profile]).order('created_at desc').page(params[:page]).per(30)
    specialized_by_state
    render json: @questions, include: [:user, :answers, :covers, likes: [:user]]
  end

  def questioned
    @questions = @user.questions.includes([:fields, user: :profile]).order('created_at desc').page(params[:page]).per(30)
    render json: @questions, include: [:user, :answers, :covers, likes: [:user]]
  end

  def create
    @user = @current_user
    @user.build_profile if @user.profile.nil?
    @profile = @user.profile

    set_attribute

    if @user.valid? && @profile.valid?
      @user.token = SecureRandom.hex(12)
      @user.save(validate: false)
      @profile.token = SecureRandom.hex(12)
      @profile.save(validate: false)
      signin_success('profile', 'create', @user.token, @user.id)
    else
      response_bad_request('名前やパスワードが入力されているか確認してください')
    end
  end

  def update
    set_attribute

    if @user.valid? && @profile.valid?
      @user.save(validate: false)
      @profile.save(validate: false)
      response_success('profile', 'update')
    else
      response_bad_request('名前は必須項目です')
    end
  end

  private

  def find_profile
    @profile = Profile.find_by(token: params[:token])
    @user = @profile.user
  end

  def set_attribute
    user_params = params.permit(:name, :email, :password, :password_confirmation)
    @user.attributes = user_params
    profile_params = params.permit(:grade, :school, :department, :avatar, :interest_list, :lesson_list)
    @profile.attributes = profile_params
  end

  def specialized_by_state
    @questions = @questions.where(aasm_state: 'wanted')
  end
end
