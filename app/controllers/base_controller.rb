class BaseController < ApplicationController

  before_filter :build_model, only: [:new, :show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  def index
    instance_model_names_set model_class.page(params)
  end

  def new; end
  def show; end
  def edit; end

  def create
    instance_model_name_set model_class.new(params[model_name])
    instance_model_name.user = current_user
    instance_model_name.save
    respond_with instance_model_name
  end

  def update
    instance_model_name.update_attributes(params[model_name])
    respond_with instance_model_name
  end

  def destroy 
    instance_model_name.destroy unless instance_model_name
    respond_with instance_model_name, location: self.send("#{controller_name}_url")
  end

  protected
  def build_model
    instance_model_name_set model_class.find(params[:id]) if params[:id]
    instance_model_name_set model_class.new unless instance_model_name
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
