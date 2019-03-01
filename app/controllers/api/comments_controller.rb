class Api::CommentsController < Api::ApplicationController
  before_action :auth

  def create
    @cover = Cover.find(params[:cover_id])
    @comment = @cover.comments.build(comment_params)
    @comment.user_id = @current_user.id
    @comment.save
    response_success('comment', 'create')
  end

  private

  def comment_params
    params.permit(:content)
  end
end
