class QuestionsController < ApplicationController
  layout 'main_table'
  QuestionColor = %w(lime yellow orange red purple blue).freeze
  before_action :authenticate_user
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def index
    @questions = Question.search(params[:search]).includes([:fields, user: :profile]).order('created_at desc')
    @colors = QuestionColor
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(user_id: @current_user.id)
    @question.attributes = question_params
    if @question.save
      @cover = @question.covers.build(photo_message: params[:photo_message])
      if @cover.save
        redirect_to question_path(@question), notice: '質問を作成しました'
      else
        render :new
      end
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
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
      @cover = @question.covers.build(photo_message: params[:photo_message])
      if @cover.save
        redirect_to question_path(@question), notice: '質問を編集しました'
      else
        render :edit
      end
    else
      render :edit
    end
  end

  def destroy
  end

  def fire
    @question = Question.find(params[:id])
    @question.aasm.fire!(params[:event].to_sym)
    @question.save
    redirect_to question_path(@question), notice: '質問を終了しました'
  end

  private

  def question_params
    params.require(:question).permit(:title, :field_list)
  end
end
