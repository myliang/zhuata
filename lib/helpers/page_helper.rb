module PageHelper
  def page(entries)
    prev = entries.previous_page
    nxt = entries.next_page
    base_url = "#{request.url}"
    urls = base_url.split('?')
    if urls.length > 1
      base_url.gsub!(/page=\d+/, "page=")
    else
      base_url << "?page="
    end

    html = <<-HTML
      <ul class="page">
        <li class="prev">
          <a href="#{prev ? "#{base_url}#{prev}" : "#"}" class="#{prev ? "" : "disabled"}">&lt;&lt;</a>
        </li>
        <li class="current">
          <a href="#" class="disabled">#{entries.current_page}</a>
        </li>
        <li class="next #{nxt ? "" : "disabled"}">
          <a href="#{nxt ? "#{base_url}#{nxt}" : "#"}" class="#{nxt ? "" : "disabled"}">&gt;&gt</a>
        </li>
      </ul>
    HTML
    html.html_safe
  end

  def ajax_page(url)
    html= <<-HTML
      <ul class="page js-paginate" data-url="#{url}">
        <li class="prev">
          <a href="#">&lt;&lt;</a>
        </li>
        <li class="current">
          <a href="#" class="disabled">1</a>
        </li>
        <li class="next">
          <a href="#">&gt;&gt;</a>
        </li>
      </ul>
    HTML
    html.html_safe
  end
end
