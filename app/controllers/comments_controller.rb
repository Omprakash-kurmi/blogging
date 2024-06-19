class CommentsController < ApplicationController
  before_action :authenticate_user! # Ensure users are authenticated
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      # Send email notification for new comment
      CommentMailer.new_comment_notification(@comment).deliver_later
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'Failed to create comment.'
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post, notice: 'Comment was successfully deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end 

  def mail_notification
	CommentMailer.new_comment_notification(@comment).deliver_later
	CommentMailer.new_like_notification(@like).deliver_later
  end
end
