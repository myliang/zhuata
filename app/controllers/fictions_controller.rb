class FictionsController < ContentController

  def chapters
    build_model
    model = instance_model
    number = params[:page]
    @chapter = Chapter.new

    if model.chapters.length >= number.to_i
      # read chapter_base_path + number.txt file
      file_name = "#{Rails.root}/data/fictions/#{model.chapter_base_path}/#{number}.txt"
      begin
        @chapter = model.chapters[number.to_i - 1]
        @chapter.content = IO.read(file_name)

      rescue => err
        puts "::::#{err}"
      end
    end

    paginator = ::Plucky::Pagination::Paginator.new(model.chapters.length, number.to_i, 1)
    @chapter.extend(::Plucky::Pagination::Decorator)
    @chapter.paginator(paginator)
  end

end
