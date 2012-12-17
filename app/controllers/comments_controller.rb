class CommentsController < ApplicationController

  before_filter :authenticate_user!, only: [:create]

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.save
    render json: @comment
  end

  def index
    @comments = Comment.page(params)
    respond_to do |format|
      format.html { render "index" }
      format.json { render @comments }
    end
  end

end
