class CommentsController < ApplicationController
  protect_from_forgery except: [:create, :destroy]
  # layout 'main_table'
  before_action :authenticate_user
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def create
    @cover = Cover.find(params[:cover_id])
    @comment = @cover.comments.build(comment_params)
    @comment.user_id = @current_user.id
    # @comment.attributes = comment_params
    if @comment.save
      render :index
    end
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def ensure_correct_user
    @comment = Comment.find(params[:id])
    if @comment.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to questions_path
    end
  end
end
