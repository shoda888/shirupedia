class Api::QuestionsController < Api::ApplicationController
  before_action :auth

  def index
    specialized_by_belongs
    specialized_by_tag
    specialized_by_state
    render json: @questions.page(params[:page]).per(20), include: [:user, :answers, :covers, likes: [:user]]
  end

  def show
    @question = Question.find(params[:id])
    render json: @question, include: [:user, covers: [comments: [:user]], answers: [:user, covers: [comments: [:user]]], likes: [:user]]
  end

  def create
    @question = Question.new(user_id: @current_user.id)
    @question.attributes = question_params
    if @question.save
      @question.covers.create(role: 'text')
      response_success('question', 'create', @question.id)
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
    @questions = if params[:department]
                   Question.where(user_id: Profile.where(department: params[:department]).pluck(:user_id)).search(params[:search])
                 elsif params[:school]
                   Question.where(user_id: Profile.where(school: params[:school]).pluck(:user_id)).search(params[:search])
                 else
                   Question.search(params[:search])
                 end
  end

  def specialized_by_state
    @questions = @questions.where(aasm_state: 'wanted').order('created_at desc')
  end
end
