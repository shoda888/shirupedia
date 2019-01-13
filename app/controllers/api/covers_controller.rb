class Api::CoversController < Api::ApplicationController
  before_action :auth

  def create
    @cover = Cover.new(coverable_type: 'Question', coverable_id: params[:id])
    @cover.attributes = cover_params
    @cover.save!
    response_success('cover', 'create')
  end

  def destroy
    @cover = Cover.find(params[:id])
    @cover.destroy!
    response_success('cover', 'destroy')
  end

  private

  def cover_params
    params.permit(:photo_message)
  end
end
