class CoversController < ApplicationController
  protect_from_forgery except: [:create, :destroy]
  layout 'main_table'
  before_action :authenticate_user
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def create
    # @cover = @question.covers.build(photo_message: params[:photo_message])
    @cover = Cover.new(coverable_type: 'Question', coverable_id: params[:id])
    @cover.attributes = cover_params
    if @cover.save
      @question = @cover.question
      @question.publish! if @question.non_published?
      render json: { message: 'success', itemId: @cover.id }, status: 200
      # redirect_to questions_path, notice: '質問を作成しました'
    else
      render :new
    end
  end

  def destroy
    @cover = Cover.find(params[:id])
    @cover.destroy
    respond_to do |format|
      format.json do
        render json: { id: @cover.id }
      end
    end
  end

  private

  def cover_params
    params.permit(:photo_message)
  end

  def ensure_correct_user
    @cover = Cover.find(params[:id])
    if @cover.coverable.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to questions_path
    end
  end
end
