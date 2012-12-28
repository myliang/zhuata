class ContentController < BaseController

  before_filter :build_user, only: [:index]
  before_filter :hot_tags, only: [:index, :tag, :search]
  before_filter :related_models, only: [:show, :edit]

  def search
    search = model_class.search do
      fulltext params[:q] do
        highlight :title
      end
      with state: SpiderField::STATE_FINISHED
      order_by :created_at, :desc
      paginate page: params[:page], per_page: 20
    end

    search.each_hit_with_result do |hit, result|
      result.title = hit.highlights(:title).map do |highlight|
        highlight.format { |word| "<span style='color: #DD4B39;'>#{word}</span>" }
      end.join
    end
    instance_models_set search.results
    render :index
  end

  def index
    unless params[:user_id]
      params[:state] = ::ContentField::STATE_FINISHED
    end
    super
  end

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
