class QuestionsController < ApplicationController
  protect_from_forgery except: [:create]
  layout 'main_table'
  QuestionColor = %w(lime light-green green teal cyan light-blue ).freeze
  before_action :authenticate_user
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def index
    @questions = Question.search(params[:search]).where.not(aasm_state: 'non_published').includes([:fields, user: :profile]).order('created_at desc').page(params[:page]).per(30)
    @colors = QuestionColor
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(user_id: @current_user.id)
    @question.attributes = question_params
    if @question.save
      redirect_to question_path(@question), notice: '質問を登録しました'
    else
      flash[:notice] = "タイトルは必須です"
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @covers = @question.covers
    @answers = @question.answers.includes(:user).order('created_at desc')
    @question_user = @question.user
    @avatar = @question_user.profile.avatar.thumb
    @answered_by_me = @answers.find_by(user_id: @current_user.id)
    @related_questions = @question.find_related_fields
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.attributes = question_params
    if @question.save
      redirect_to question_path(@question), notice: '質問を編集しました'
    else
      flash[:notice] = "タイトルは必須です"
      render :edit
    end
  end

  def destroy
  end

  def fire
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @question.finish!
    redirect_to question_path(@question), notice: '質問が終了しました'
  end

  private

  def question_params
    params.require(:question).permit(:title, :field_list)
  end

  def ensure_correct_user
  end
end
