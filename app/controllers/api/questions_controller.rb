class Api::QuestionsController < Api::ApplicationController
  before_action :auth

  def index
    specialized_by_belongs
    specialized_by_tag
    specialized_by_state
    render json: @questions, include: [:user, :answers, :covers, likes: [:user]]
  end

  def show
    @question = Question.find(params[:id])
    render json: @question, include: [:user, :covers, answers: [:covers, :user], likes: [:user]]
  end

  def create
    @question = Question.new(user_id: @current_user.id)
    @question.attributes = question_params
    if @question.save
      response_success('question', 'create')
    else
      response_bad_request('タイトルは必須です')
    end
  end

  def update
    @question = Question.find(params[:id])
    @question.attributes = question_params
    if @question.save
      response_success('question', 'update')
    else
      response_bad_request('タイトルは必須です')
    end
  end

  private

  def question_params
    params.permit(:title, :field_list, :text_message)
  end

  def specialized_by_tag
    @fields = params[:fields]
    if @fields.present?
      @questions = @questions.tagged_with(@fields.split, any: true)
    end
  end

  def specialized_by_belongs
    @school = params[:school]
    @department = params[:department]
    @questions = if @department
                   Question.find_same_department_questions_exclude_mine(params[:department], @current_user.id).search(params[:search])
                 elsif @school
                   Question.find_same_school_questions_exclude_mine(params[:school], @current_user.id).search(params[:search])
                 else
                   Question.search(params[:search])
                 end
  end

  def specialized_by_state
    @questions = @questions.where(aasm_state: 'wanted')
  end
end
