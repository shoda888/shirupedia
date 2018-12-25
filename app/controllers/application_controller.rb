class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session
  protect_from_forgery with: :exception
  # QuestionColor = %w(lime light-green green teal cyan light-blue ).freeze
  before_action :set_current_user
  before_action :request_ogp

  def request_ogp
    # @url = request.url
    @ogp = Ogp.new({ title: "Shirupedia", description: "東工大の学生を対象に授業・講義、学生生活の疑問点を解消するアプリケーション", image: "./public/shirupedia_logo.png" })
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    unless @current_user
      flash[:notice] = "ログインが必要です"
      redirect_to new_sessions_path
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to questions_path
    end
  end

  # def ensure_correct_user
  #   @question = Question.find(params[:id])
  #   if @question.user_id != @current_user.id
  #     flash[:notice] = "権限がありません"
  #     redirect_to questions_path
  #   end
  # end
end
