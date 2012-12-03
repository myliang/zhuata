class ContentController < ApplicationController

  before_filter :build_model, :authenticate_user!, except: [:index, :tag]
  # before_filter :authenticate_user!, except: [:index, :tag]

  def index
    instance_model_names_set model_class.page(build_params)
  end

  def tag
    index
    render :index
  end

  def new; end

  def show 
    instance_model_name.update_read_count
    @comment = Comment.new(:commentable => instance_model_name)
  end

  def edit; end

  def create
    instance_model_name_set model_class.new(params[model_name])
    instance_model_name.user = current_user
    instance_model_name.save
    respond_with instance_model_name, :location => blogs_url
  end

  def update
    instance_model_name.old_tags = instance_model_name.tags
    instance_model_name.update_attributes(params[model_name])
    respond_with instance_model_name, :location => blogs_url
  end

  def build_model
    instance_model_name_set model_class.find(params[:id]) if params[:id]
    instance_model_name_set model_class.new unless instance_model_name
  end

  def build_params
    hash = {:order => :created_at.desc}
    params.each do |k, v|
      hash[k.to_sym] = v unless ["controller", "action"].include?(k)
    end
    hash
  end

  def model_class
    controller_name.classify.constantize
  end
  def model_name
    controller_name.singularize
  end
  def instance_model_name
    instance_variable_get("@#{model_name}")
  end
  def instance_model_name_set(v)
    instance_variable_set("@#{model_name}", v)
  end
  def instance_model_names_set(v)
    instance_variable_set("@#{controller_name}", v)
  end

end
