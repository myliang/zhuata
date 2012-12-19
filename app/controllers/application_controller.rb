class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json

  def render_ajax_page(models)
    self.formats = [:html]
    json =  {per_page: models.per_page, total_pages: models.total_pages}
    json[:content] = render_to_string models
    render json: json
  end

  def render_ajax(model)
    self.formats = [:html]
    json = {errors: model.errors}
    json[:content] = render_to_string([model])
    render json: json
  end

end
