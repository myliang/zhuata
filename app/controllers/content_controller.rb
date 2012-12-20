class ContentController < BaseController

  before_filter :build_user, only: [:index]
  before_filter :hot_tags, only: [:index, :tag]

  def tag
    index
    render :index
  end

  def show 
    unless instance_model.user == current_user
      instance_model.update_read_count
    end
    @comment = Comment.new(:commentable => instance_model)
  end

  private
  def build_user
    if params[:user_id]
      @user = User.find(params[:user_id])
      @message = Message.new(to_user: @user)
    end
  end

  def hot_tags
    @hot_tags = "#{controller_name.classify}Tag".constantize.sort(:counter.desc).limit(10)
  end

end
