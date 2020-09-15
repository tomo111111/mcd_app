class CommentsController < ApplicationController

  def new
  
  end

  def create
    Comment.create(comment_params)
    redirect_to root_path
  end

  def edit

  end

  def update

  end

  def checked
    day_comments = Comment.where(date:@starting_point + (params[:id]).to_i)
    render json:{com:day_comments}
  end

  private

  def comment_params
    params.require(:comment).permit(:text,:date).merge(user_id:current_user.id)
  end

end
