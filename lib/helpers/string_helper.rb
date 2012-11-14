module StringHelper
  # get content except html tags by text
  # cut_remove_html "<p>ni hao</p>" => "ni hao"
  def cut_remove_html(text, *args)
    # ary = text.scan(/[\/]?>([^<>]*)<?/)
    content = text.gsub(/<[^<>]*\/?>/, "")
    if args.length > 0
      content = content[0, args[0]] if content.length > args[0]
    end
    content
  end
end
