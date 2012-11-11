class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    @comment.save
    render :json => @comment
  end
end
