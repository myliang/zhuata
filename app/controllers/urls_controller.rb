class UrlsController < ApplicationController
  def index
    @urls = Url.where(_type: params[:type]).all
  end
end
