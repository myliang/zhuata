class BlogsController < ApplicationController

  before_filter :build_blog, :except => [:index, :tag]
  before_filter :authenticate_user!, :except => [:index, :tag]

  def index
    @blogs = Blog.page(build_params)
  end

  def tag
    index
    render :index
  end

  def new; end

  def show; end

  def edit; end

  def create
    @blog = Blog.new(params[:blog])
    @blog.user = current_user
    @blog.save
    respond_with @blog, :location => blogs_url
  end

  def update
    @blog.old_tags = @blog.tags
    @blog.update_attributes(params[:blog])
    respond_with @blog, :location => blogs_url
  end

  private
  def build_blog
    @blog = Blog.find(params[:id]) if params[:id]
    @blog ||= Blog.new
  end

  def build_params
    hash = {:order => :created_at.desc}
    params.each do |k, v|
      hash[k.to_sym] = v unless ["controller", "action"].include?(k)
    end
    hash
  end

end
