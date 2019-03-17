class Api::ReportsController < Api::ApplicationController
    before_action :auth
  
    def create
      UserMailer.send_report(params[:question_id], params[:content], @current_user.name, @current_user.id).deliver_now
      response_success('report', 'create')
    end

end
  