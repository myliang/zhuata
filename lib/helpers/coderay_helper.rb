module CoderayHelper
  def highlighter(html)
    html.gsub(/<code language="(.+?)">(.+?)<\/code>/m) do
      CodeRay.scan($2, $1).div # (:line_numbers => :table)
    end.html_safe
  end
end


