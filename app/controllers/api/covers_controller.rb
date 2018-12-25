class Api::CoversController < Api::ApplicationController
  before_action :auth

  def create
    @cover = Cover.new(coverable_type: 'Question', coverable_id: params[:id])
    @cover.attributes = cover_params
    if @cover.save
      @question = @cover.coverable
      response_success('cover', 'create')
    else
      response_bad_request
    end
  end

  def destroy
    @cover = Cover.find(params[:id])
    if @cover.destroy
      response_success('cover', 'destroy')
    else
      response_bad_request
    end
  end

  private

  def cover_params
    params.permit(:photo_message)
  end
end
