class ProfilesController < ApplicationController
  layout 'main_table'
  before_action :set_current_user, except: [:new, :create]
  before_action :authenticate_user, only: [:show, :edit, :update, :destroy, :answered, :questioned]
  before_action :request_path
  before_action :find_profile, only: [:answered, :questioned, :recommended, :show, :edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def request_path
    @path = controller_path + '#' + action_name
  end

  def answered
    @questions = @user.answeredquestions.includes([:fields, user: :profile]).order('created_at desc').page(params[:page]).per(20)
    # specialized_by_state
    render layout: 'cms_table'
  end

  def questioned
    @questions = @user.questions.includes([:fields, user: :profile]).order('created_at desc').page(params[:page]).per(20)
    render layout: 'cms_table'
  end

  def recommended
    @questions = Question.where(user_id: Profile.where(school: @profile.school).pluck(:user_id) - [@user.id]) # 同じ学院の他人の質問を取得
    specialized_by_state
    render layout: 'cms_table'
  end

  def show
    @questions = @user.questions.includes([:fields, user: :profile]).order('created_at desc').page(params[:page]).per(20)
    render layout: 'cms_table'
  end

  def edit
    @sodan = @user.email.match?(/\Asodan/)
  end

  def update
    set_attribute

    user_valid = @user.valid?
    profile_valid = @profile.valid?

    if profile_valid && user_valid
      @user.save(validate: false)
      @profile.save(validate: false)
      redirect_to profile_path(@profile.token), notice: 'ユーザー情報を編集しました'
    else
      @errors = @user.errors.full_messages + @profile.errors.full_messages
      render :edit
    end
  end

  # 初回登録
  def new
    @user ||= User.find_by(token: params[:token])
    @profile = @user.profile || Profile.new
    @token = @user.token
    @sodan = @user.email.match?(/\Asodan/)
    render layout: 'application'
  end

  def create
    @user ||= User.find_by(token: params[:user][:token])
    @user.build_profile if @user.profile.nil?
    @profile = @user.profile

    set_attribute

    if @user.valid? && @profile.valid?
      @user.token = SecureRandom.hex(12)
      @user.save(validate: false)
      @profile.token = SecureRandom.hex(12)
      @profile.save(validate: false)
      session[:user_id] = @user.id
      redirect_to profile_path(@profile.token), notice: 'ユーザー情報を登録しました'
    else
      @errors = @user.errors.full_messages + @profile.errors.full_messages
      render :new, layout: 'application'
    end
  end

  private

  def find_profile
    @profile = Profile.find_by(token: params[:token])
    @user = @profile.user
  end

  def set_attribute
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user.attributes = user_params
    profile_params = params.require(:profile).permit(:grade, :school, :department, :avatar, :interest_list, :lesson_list)
    @profile.attributes = profile_params
  end

  # def find_all_covers
  #   @covers = []
  #   @user.questions.each do |q|
  #     q.covers.where(role: 'photo').each do |c|
  #       @covers << c
  #     end
  #   end
  #   @user.answers.each do |a|
  #     a.covers.each do |c|
  #       @covers << c
  #     end
  #   end
  #   @covers.sort! do |a, b|
  #     a.created_at <=> b.created_at
  #   end
  # end

  def specialized_by_state
    @questions = @questions.where(aasm_state: 'wanted').order('created_at desc').page(params[:page]).per(20)
  end

  def ensure_correct_user
    if @user.id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to profile_path(@profile.token)
    end
  end
end
