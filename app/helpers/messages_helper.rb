module MessagesHelper
  def user_message_navs
    content_tag :ul, class: "nav stacked" do
      ["unread", "to", "from"].map do |ele|
        active = action_name == ele ? "active" : ""
        content_tag :li,
          link_to(t(ele, scope: [:helpers, :message]), "/messages/#{ele}"),
          class: active
      end.join.html_safe
    end
  end
end
