class Api::ReportsController < Api::ApplicationController
  before_action :auth

  def create
    @question = Question.find(params[:question_id])
    UserMailer.send_report(@question.share_url, params[:content], @current_user.name, @current_user.id).deliver_now
    response_success('report', 'create')
  end
end
