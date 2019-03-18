class ReportsController < ApplicationController
  before_action :authenticate_user

  def create
    UserMailer.send_report(params[:question_id], params[:content], @current_user.name, @current_user.id).deliver_now
    redirect_to question_path(params[:question_id]), notice: '質問を報告しました'
  end
end
