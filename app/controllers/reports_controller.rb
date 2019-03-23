class ReportsController < ApplicationController
  before_action :authenticate_user

  def create
    @question = Question.find(params[:question_id])
    UserMailer.send_report(@question.share_url, params[:content], @current_user.name, @current_user.id).deliver_now
    redirect_to question_path(params[:question_id]), notice: '質問を報告しました'
  end
end
