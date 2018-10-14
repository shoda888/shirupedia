class NicesController < ApplicationController
  before_action :authenticate_user
  def create
    @cover = Cover.find(params[:cover_id])
    @question = @cover.coverable.question
    @cover.nice(@current_user) unless @cover.nice?(@current_user)
  end

  def destroy
    @cover = Nice.find(params[:id]).cover
    @question = @cover.coverable.question
    @cover.nice_cancel(@current_user) if @cover.nice?(@current_user)
  end
end
