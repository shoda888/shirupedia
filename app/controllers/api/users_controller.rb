class Api::UsersController < Api::ApplicationController
  before_action :auth, except: [:signin, :signup]

  def index # いらないかな
    @users = User.all
    render json: @users, include: [:profile]
  end

  def recommended
    @user = User.find(params[:id])
    @profile = @user.profile
    @questions = Question.where(user_id: Profile.where(school: @profile.school).pluck(:user_id) - [@user.id] - @current_user.blocks.pluck(:target_user_id)) # 同じ学院の他人の質問を取得
    specialized_by_state
    render json: @questions.page(params[:page]).per(20), scope:{current_user_id: @current_user.id}, include: [:user, :answers, :covers, likes: [:user]]
  end

  ## ブロック処理
  def block
    @user = User.find(params[:id])
    @current_user.block(@user) unless @current_user.blocked?(@user)
    response_success('user', 'block')
  end

  def unblock
    @user = User.find(params[:id])
    @current_user.unblock(@user) if @current_user.blocked?(@user)
    response_success('user', 'unblock')
  end

  ## サインアップ
  def signup
    @user = User.new(name: params[:name], email: params[:email])
    if @user.valid?
      @user.save
      # http://localhost:1080/でメール確認
      UserMailer.created_with_email(@user, @user.token).deliver_now
      response_success('user', 'signup')
    else
      response_internal_server_error('有効なmアドレスを入力してください')
    end
  end

  ## サインイン
  def signin
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      @user.token = SecureRandom.hex(12)
      @user.save
      signin_success('user', 'signin', @user.token, @user.id)
    else
      response_internal_server_error('メールまたはパスワードが間違っています')
    end
  end

  def show
    @user = User.find(params[:id])
    render json: @user, scope:{current_user_id: @current_user.id}, include: [:profile]
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

  def specialized_by_state
    @questions = @questions.where(aasm_state: 'wanted').order('created_at desc')
  end
end
