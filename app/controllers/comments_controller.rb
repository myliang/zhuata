class CommentsController < BaseController

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.save
    render_ajax @comment
  end

  def index
    ["Blog", "AudioBook", "Fiction", "Picture"].each do |str|
      key = "#{str.tableize.singularize}_id"
      puts "::::key=#{params[key]}"
      if params[key]
        params[:commentable_id] = params[key]
        params[:commentable_type] = str
        params.delete(key)
        break
      end
    end

    @comments = Comment.page(params)
    respond_to do |format|
      format.html { render "index" }
      format.json { render_ajax_page @comments }
    end
  end

end
