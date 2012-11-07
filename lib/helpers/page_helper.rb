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
      <ul class="pager">
        <li class="previous #{prev ? "" : "disabled"}">
          <a href="#{prev ? "#{base_url}#{prev}" : "#"}"><< prev</a>
        </li>
        <li class="next #{nxt ? "" : "disabled"}">
          <a href="#{nxt ? "#{base_url}#{nxt}" : "#"}">Next >></a>
        </li>
      </ul>
    HTML
    html.html_safe
  end
end
