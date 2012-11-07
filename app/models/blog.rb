class Blog < Content

  key :title, String, :required => true
  key :text, String, :required => true

  def short_text
    # ary = text.scan(/([^<>]*)<br(\/)?>/)
    ary = text.scan(/>([^<>]*)</)
    content = ary.length > 0 ? ary.map{|ele| ele[0]}.join : text
    "#{content.length > 200 ? content[0, 200] : content}..." 
  end

end
