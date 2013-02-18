class FictionsController < ContentController

  def chapters
    build_model
    model = instance_model
    number = params[:page]
    out_json = {content: "", per_page: 1, total_pages: model.chapters.length}
    if model.chapters.length >= number.to_i
      # read chapter_base_path + number.txt file
      file_name = "#{Rails.root}/data/fictions/#{model.chapter_base_path}/#{number}.txt"
      out_json[:content] = IO.read(file_name)
    end
    render :json => out_json
  end

end
