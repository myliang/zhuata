class BaseController < ApplicationController

  before_filter :build_model, only: [:new, :show, :edit, :update, :destroy]
  before_filter :access_denied, only: [:edit, :update, :destroy]

  def index
    result = model_class.page(params)
    instance_models_set  result
  end

  def new; end
  def show
    seo_msg(instance_model.title, 
        "#{instance_model.title} #{instance_model.tags.join(' ')}", 
        instance_model.title)
  end
  def edit; end

  def create
    instance_model_set model_class.new(params[model_name])
    instance_model.user = current_user
    instance_model.save
    respond_with instance_model
  end

  def update
    instance_model.update_attributes(params[model_name])
    respond_with instance_model
  end

  def destroy
    instance_model.destroy if instance_model
    respond_with instance_model, location: index_url
  end

  protected
  def render_ajax_page(models)
    self.formats = [:html]
    json = {per_page: models.per_page, total_pages: models.total_pages}
    json[:content] = render_to_string models
    render json: json
  end

  def render_ajax(model)
    self.formats = [:html]
    json = {errors: model.errors}
    json[:content] = render_to_string([model])
    render json: json
  end

  def access_denied
    if instance_model.kind_of? Message
      user_id = instance_model.from_user_id
    else
      user_id = instance_model.user_id
    end

    puts "::::#{instance_model}"
    puts "::::#{user_id}== session.user.id = #{current_user.id}"

    unless user_id == current_user.id
      flash[:alert] = I18n.t("errors.messages.access_denied")
      redirect_to index_url
    end
  end

  def index_url
    self.send("#{controller_name}_url")
  end

  def build_model
    instance_model_set model_class.find(params[:id]) if params[:id]
    instance_model_set model_class.new unless instance_model
  end

  def model_class
    controller_name.classify.constantize
  end
  def model_name
    controller_name.singularize
  end
  def instance_model
    instance_variable_get("@#{model_name}")
  end
  def instance_model_set(v)
    instance_variable_set("@#{model_name}", v)
  end
  def instance_models_set(v)
    instance_variable_set("@#{controller_name}", v)
  end


end
