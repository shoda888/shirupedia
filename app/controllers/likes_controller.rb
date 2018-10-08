class LikesController < ApplicationController
  before_action :authenticate_user
  def create
    @question = Question.find(params[:question_id])
    unless @question.iine?(@current_user)
      @question.good(@current_user)
    end
  end

  def destroy
    @question = Like.find(params[:id]).question
    if @question.iine?(@current_user)
      @question.good_cancel(@current_user)
    end
  end
end
