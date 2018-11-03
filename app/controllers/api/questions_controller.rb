class Api::QuestionsController < Api::ApplicationController
  def index
    @questions = Question.all
    render json: @questions
  end
  def show
    @question = Question.find(params[:id])
    render json: @question
  end
  private

  def question_params
    params.require(:question).permit(:title)
  end
end
