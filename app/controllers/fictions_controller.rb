class FictionsController < ContentController

  def chapters
    build_model
    model = instance_model
    number = params[:page]
    @chapter = Chapter.new

    if model.chapters.length >= number.to_i
      begin
        @chapter = model.chapters[number.to_i - 1]
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
