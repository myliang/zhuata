class ContentController < BaseController

  before_filter :build_user

  def tag
    index
    render :index
  end

  def show 
    unless instance_model_name.user == current_user
      instance_model_name.update_read_count
    end
    @comment = Comment.new(:commentable => instance_model_name)
  end

  private
  def build_user
    if params[:user_id]
      @user = User.find(params[:user_id])
      @message = Message.new(to_user: @user)
    end
  end

end
