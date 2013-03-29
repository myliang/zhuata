class AudioBooksController < ContentController

  def parse
    url = params[:url]
    result = {state: 0, message: "arguments is not blank"}
    unless url.blank?
      result[:state] = 1
      result[:message] = Spider.read(Spider::AUDIO_BOOK_HASH, url)
    end
    render :json => result
  end
end
