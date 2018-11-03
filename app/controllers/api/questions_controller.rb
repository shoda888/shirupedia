class Api::QuestionsController < Api::ApplicationController
  def index
    @questions = Question.all
    render json: @questions, include: [:user, :answers, :likes, :covers]
  end

  def show
    @question = Question.find(params[:id])
    render json: @question, include: [:user, :answers, :likes, :covers]
  end

  private

  def question_params
    params.require(:question).permit(:title)
  end
end
