require 'helpers/message_helper'
require 'helpers/page_helper'
module ApplicationHelper

  include MessageHelper
  include PageHelper

  def t_form_title(model, action)
    I18n.t("helpers.submit.#{action}", :model => t("models.#{model.class.to_s.downcase}"))
  end

  def menus
    controller_name = params["controller"]
    content_tag :ul, :class => "nav" do
      ["compare", "fiction", "picture", "blog"].map do |ele|
        active = controller_name == ele.pluralize ? "active" : ""
        content_tag :li, 
          link_to(t(ele, scope: :menus), "/#{ele.pluralize}"),
          :class => active
      end.join.html_safe
    end

    # html = <<-HTML
    #   <ul class="nav">
    #     #{content}
    #   </ul>
    # HTML

    # content.html_safe
  end

  def edit_user_tabs
    action_name = params[:action]
    content_tag :ul, :class => "nav nav-tabs" do
      ["edit", "edit_pwd", "edit_avatar"].map do |ele|
        active = action_name == ele ? "active" : ""
        content_tag :li,
          link_to(t(ele, scope: [:attributes, :user, :settings]), "/users/#{ele}"),
          :class => active
      end.join.html_safe
    end
  end

end
