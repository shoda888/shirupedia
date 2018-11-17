class Api::AnswersController < Api::ApplicationController
  before_action :auth

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.find_or_create_by(user_id: @current_user.id)
    @answer.attributes = answer_params
    # @answer.save if @answer.new_record? || @answer.changed? #text_messageが有効になったときのchanged?メソッド
    if !@answer.changed? || @answer.save #answerが変わってなければそのまま
      @cover = @answer.covers.new(coverable_type: 'Answer', coverable_id: @answer.id)
      @cover.attributes = cover_params
      if @cover.save
        response_success('answer', 'create')
      else
        response_bad_request
      end
    else
      response_bad_request
    end
  end


  private

  def cover_params
    params.permit(:photo_message)
  end
  def answer_params
    params.permit(:text_message)
  end

end
