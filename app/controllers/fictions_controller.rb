# encoding=utf-8
class FictionsController < ContentController

  def search
    seo_msg("小说 刊物 书 电子书搜索", "抓取 小说 刊物 书 电子书", 
            "关注 阅读自己喜欢的小说 刊物 书 电子书")
    super
  end

  def index
    seo_msg("小说 刊物 书 电子书", "抓取 小说 刊物 书 电子书", 
            "关注 阅读自己喜欢的小说 刊物 书 电子书")
    super
  end

  def chapters
    build_model
    model = instance_model
    number = params[:page]
    @chapter = Chapter.new

    seo_title = "#{@chapter.title} #{model.title}"
    seo_msg(seo_title, seo_title, seo_title)

    if model.chapters.length >= number.to_i
      begin
        @chapter = model.chapters[number.to_i]
        @chapter.content = Spider.read(Spider::BOOK_HASH, @chapter.url)
      rescue => err
        puts "::::#{err}"
      end
    end

    paginator = ::Plucky::Pagination::Paginator.new(model.chapters.length, number.to_i, 1)
    @chapter.extend(::Plucky::Pagination::Decorator)
    @chapter.paginator(paginator)

    render layout: 'simple'
  end

end
