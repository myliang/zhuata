require 'helpers/message_helper'
require 'helpers/page_helper'
require 'helpers/string_helper'
require 'helpers/redcarpet_helper'
require 'helpers/coderay_helper'

module ApplicationHelper

  include MessageHelper
  include PageHelper
  include StringHelper
  include RedcarpetHelper
  include CoderayHelper

  MENUS = ["fiction", "audio_book", "blog"]

  def t_form_title(model, action)
    I18n.t("helpers.submit.#{action}", model: t("models.#{model.class.to_s.tableize.singularize}"))
  end

  def t_submit(action)
    I18n.t("helpers.submit.#{action}")
  end

  def new_menus
    content_tag :ul, class: "menu lt" do
      MENUS.map do |ele|
        if ele == controller_name.singularize
          ""
        else
          content_tag :li,
            link_to(t(ele, scope: :models), "/#{ele.pluralize}/new")
        end
      end.join.html_safe
    end
  end

  def user_menus(user)
    MENUS.each do |ele|
      active = (controller_name == ele.pluralize and params[:user_id]) ? "active" : ""
      yield(ele, t(ele, scope: :models), "/#{user.id}/#{ele.pluralize}", active)
    end
  end

  def menus
    content_tag :ul, class: "nav" do
      MENUS.map do |ele|
        active = (controller_name == ele.pluralize and !params[:user_id]) ? "active" : ""
        content_tag :li,
          link_to(t(ele, scope: :models), "/#{ele.tableize}"),
          class: active
      end.join.html_safe
    end
  end

  def edit_user_tabs
    content_tag :ul, class: "nav stacked" do
      ["edit", "edit_pwd", "edit_avatar"].map do |ele|
        active = action_name == ele ? "active" : ""
        content_tag :li,
          link_to(t(ele, scope: [:attributes, :user, :settings]), "/users/#{ele}"),
          class: active
      end.join.html_safe
    end
  end

end
