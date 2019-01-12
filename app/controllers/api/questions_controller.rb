class Api::QuestionsController < Api::ApplicationController
  before_action :auth

  def index
    @questions = Question.all
    render json: @questions, include: [:user, :answers, :likes, :covers]
  end

  def show
    @question = Question.find(params[:id])
    render json: @question, include: [:user, :likes, :covers, answers: [:covers]]
  end

  def create
    @question = Question.new(user_id: @current_user.id)
    @question.attributes = question_params
    if @question.save
      response_success('question', 'create')
    else
      response_bad_request
    end
  end

  def update
    @question = Question.find(params[:id])
    @question.attributes = question_params
    if @question.save
      response_success('question', 'update')
    else
      response_bad_request
    end
  end

  private

  def question_params
    params.permit(:title, :field_list, :text_message)
  end
end
