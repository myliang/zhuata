class CommentsController < ApplicationController

  before_filter :authenticate_user!, only: [:create]

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.save
    render_ajax @comment
  end

  def index
    ["Blog", "Compare", "Fiction", "Picture"].each do |str|
      key = "#{str.downcase}_id"
      if params[key]
        params[:commentable_id] = params[key]
        params[:commentable_type] = str
        params.delete(key)
      end
    end

    @comments = Comment.page(params)
    respond_to do |format|
      format.html { render "index" }
      format.json { render_ajax_page @comments }
    end
  end

end
