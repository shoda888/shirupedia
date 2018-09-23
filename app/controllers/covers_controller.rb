class CoversController < ApplicationController
  protect_from_forgery except: [:create]
  layout 'main_table'
  before_action :authenticate_user
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def create
    # @cover = @question.covers.build(photo_message: params[:photo_message])
    @cover = Cover.new(coverable_type: 'Question', coverable_id: params[:id])
    @cover.attributes = cover_params
    if @cover.save
      render json: { message: 'success', itemId: @cover.id }, status: 200
      # redirect_to questions_path, notice: '質問を作成しました'
    else
      render :new
    end
  end

  private

  def cover_params
    params.permit(:photo_message)
  end
end
