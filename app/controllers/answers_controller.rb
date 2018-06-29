class AnswersController < ApplicationController
  layout 'main_table'
  before_action :authenticate_user

  def index
    @answers = Answer.all
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(user_id: @current_user.id)
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(user_id: @current_user.id)
    @answer.attributes = answer_params
    if @answer.save
      redirect_to question_path(@question), notice: '回答しました'
    else
      render :new
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @answer_user = @answer.user
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.attributes = answer_params
    if @answer.save
      redirect_to answer_path(@answer), notice: ''
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def answer_params
    params.require(:answer).permit(:title, :content)
  end

end
