class ContentController < BaseController

  before_filter :build_user, only: [:index]
  before_filter :hot_tags, only: [:index, :tag]
  before_filter :related_models, only: [:show, :edit]

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
    @hot_tags = tag_class.sort(:counter.desc).limit(10)
  end

  def tag_class
    "#{controller_name.classify}Tag".constantize
  end

  def related_models
    @related_models = model_class.where(tags: instance_model.tags).sort(:counter.desc).limit(10)
  end

end
