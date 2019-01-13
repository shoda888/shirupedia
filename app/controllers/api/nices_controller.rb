class Api::NicesController < Api::ApplicationController
  before_action :auth

  def create
    @cover = Cover.find(params[:cover_id])
    @cover.nice(@current_user) unless @cover.nice?(@current_user)
    response_success('nice', 'create')
  end

  def destroy
    @cover = Nice.find(params[:id]).cover
    @cover.nice_cancel(@current_user) if @cover.nice?(@current_user)
    response_success('nice', 'destroy')
  end
end
