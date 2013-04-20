class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json

  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]


  def seo_msg(title, keywords, description)
    @title = title
    @keywords = keywords
    @description = description
  end

  end
