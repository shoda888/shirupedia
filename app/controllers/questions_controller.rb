class QuestionsController < ApplicationController
  layout 'main_table'
  before_action :authenticate_user

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(user_id: @current_user.id)
    @question.attributes = question_params
    if @question.save
      redirect_to questions_path
    else
      render :new
    end
  end

  def show
  end

  def edit

  end

  def update
  end

  def destroy
  end

  private
  def question_params
    params.require(:question).permit(:title, :content, :amount_paid, :tag)
  end

end
