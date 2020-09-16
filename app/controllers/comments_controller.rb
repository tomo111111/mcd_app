class CommentsController < ApplicationController

  def new
  
  end

  def create
    comment = Comment.create(comment_params)
    render json:{ post: comment }
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
    params.require(:comment).permit(:text).merge(date:Time.at(params[:comment][:date].to_i / 1000.0).strftime('%Y/%m/%d'),user_id:current_user.id)
  end

end
