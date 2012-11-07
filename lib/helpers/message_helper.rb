module MessageHelper

  def alert(resource)
    type = "warning"
    if flash[:success]
      type = "success"
      message = flash[:success]
    elsif flash[:alert]
      message = flash[:alert]
    elsif !resource.nil? and resource.respond_to? :errors
      message = resource.errors
      return "" if message.empty?
      
      message = message.full_messages.map { |msg| content_tag(:li, msg) }.join
      sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.full_messages.length,
                      :resource => resource.class.model_name.human.downcase)
      message = <<-HTML
        <strong>#{sentence}</strong>
        <ul>#{message}</ul>
      HTML
    end
    to_html(type, message)
  end

  def to_html(type, message)
    html = <<-HTML
      <div class="alert alert-#{type}">#{message}</div>
    HTML
    html.html_safe
  end

end
