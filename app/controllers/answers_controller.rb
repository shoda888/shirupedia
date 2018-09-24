class AnswersController < ApplicationController
  protect_from_forgery except: [:create]
  layout 'main_table'
  before_action :authenticate_user

  def index
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(user_id: @current_user.id)
    @question_user = @question.user
    @answer_user = @answer.user
    @question_user_avatar = @question_user.profile.avatar.thumb
    @answer_user_avatar = @answer_user.profile.avatar.thumb
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find_by(user_id: @current_user.id) || @question.answers.new(user_id: @current_user.id)
    # @answer.attributes = answer_params
    # @answer.save if @answer.new_record? || @answer.changed? #text_messageが有効になったときのchanged?メソッド
    if !@answer.changed? || @answer.save
      @cover = @answer.covers.new(coverable_type: 'Answer', coverable_id: @answer.id)
      @cover.attributes = cover_params
      if @cover.save
        respond_to do |format|
          # format.html { redirect_to questions_path, notice: '回答しました' }
          format.json { render json: @cover }
        end
      else
        render :index
      end
    else
      render :index
    end
  end

  def show
    @answer = Answer.find(params[:id])
    @answer_user = @answer.user
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @question_user = @question.user
    @answer_user = @answer.user
    @question_user_avatar = @question_user.profile.avatar.thumb
    @answer_user_avatar = @answer_user.profile.avatar.thumb
  end

  def update
    # @question = Question.find(params[:question_id])
    # @answer = Answer.find(params[:id])
    # @answer.attributes = answer_params
    # if @answer.save
    #   @cover = @answer.covers.build(photo_message: params[:photo_message])
    #   if @cover.save
    #     redirect_to questions_path, notice: '回答しました'
    #   else
    #     render :new
    #   end
    # else
    #   render :new
    # end
  end

  def destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:text_message)
  end
  def cover_params
    params.permit(:photo_message)
  end
end
