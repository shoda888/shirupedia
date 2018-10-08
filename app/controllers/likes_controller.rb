class LikesController < ApplicationController
  before_action :authenticate_user
  def create
    @question = Question.find(params[:question_id])
    @question.good(@current_user) unless @question.iine?(@current_user)
  end

  def destroy
    @question = Like.find(params[:id]).question
    @question.good_cancel(@current_user) if @question.iine?(@current_user)
  end
end
