class CommentMailer < ApplicationMailer
  def new_comment_notification(comment)
    @comment = comment
    @post = comment.post
    @user = @post.user # Assuming Post belongs_to User

    mail(to: @user.email, subject: 'New Comment on Your Post')
  end

  def new_like_notification(like)
    @like = like
    @post = like.post
    @user = @post.user # Assuming Post belongs_to User

    mail(to: @user.email, subject: 'New Like on Your Post')
  end
end
