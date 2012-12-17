class ContentController < BaseController

  def tag
    index
    render :index
  end

  def show 
    instance_model_name.update_read_count
    @comment = Comment.new(:commentable => instance_model_name)
  end

end
