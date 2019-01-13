class Api::LikesController < Api::ApplicationController
  before_action :auth

  def create
    @question = Question.find(params[:question_id])
    @question.good(@current_user) unless @question.iine?(@current_user)
    response_success('like', 'create')
  end

  def destroy
    @question = Like.find(params[:id]).question
    @question.good_cancel(@current_user) if @question.iine?(@current_user)
    response_success('like', 'destroy')
  end
end
