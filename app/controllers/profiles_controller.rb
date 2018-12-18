class ProfilesController < ApplicationController
  layout 'main_table'
  before_action :set_current_user, except: [:new, :create]
  before_action :authenticate_user, only: [:show, :edit, :update, :destroy, :answered, :questioned]
  before_action :request_path
  before_action :find_profile, only: [:answered, :questioned, :recommended, :show, :edit, :update]

  def request_path
    @path = controller_path + '#' + action_name
  end

  def answered
    @questions = @user.answeredquestions.includes([:fields, user: :profile]).order('created_at desc').page(params[:page]).per(30)
    render layout: 'cms_table'
  end

  def questioned
    @questions = @user.questions.includes([:fields, user: :profile]).order('created_at desc').page(params[:page]).per(30)
    render layout: 'cms_table'
  end

  def recommended
    @questions = Question.find_same_school_questions_exclude_mine(@profile.school, @user.id).includes([:fields, user: :profile]).order('created_at desc').page(params[:page]).per(30)
    render layout: 'cms_table'
  end

  def show
    find_all_covers
    render layout: 'cms_table'
  end

  def edit
  end

  def update
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

  # 初回登録
  def new
    @user ||= User.find_by(token: params[:token])
    @profile = @user.profile || Profile.new
    @token = @user.token
    render layout: 'application'
  end

  def create
    @token = params[:user][:token]
    @user ||= User.find_by(token: @token)
    @user.build_profile if @user.profile.nil?
    @profile = @user.profile

    set_attribute

    if @user.valid? && @profile.valid?
      @user.token = SecureRandom.hex(12)
      @user.save(validate: false)
      @profile.token = SecureRandom.hex(12)
      @profile.save(validate: false)
      session[:user_id] = @user.id
      redirect_to questions_path, notice: 'ユーザー情報を登録しました'
    else
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
    profile_params = params.require(:profile).permit(:grade, :school, :department, :lesson, :avatar, :interest_list, :lesson_list)
    @profile.attributes = profile_params
  end

  def find_all_covers
    @covers = []
    @user.questions.each do |q|
      q.covers.each do |c|
        @covers << c
      end
    end
    @user.answers.each do |a|
      a.covers.each do |c|
        @covers << c
      end
    end
    @covers.sort! do |a, b|
      a.created_at <=> b.created_at
    end
  end
end
