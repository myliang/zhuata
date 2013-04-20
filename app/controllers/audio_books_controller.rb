# encoding=utf-8
class AudioBooksController < ContentController

  def search
    seo_msg("有声读物 评书 小说搜索", "抓取 有声读物 评书 小说", 
            "关注 聆听自己喜欢的有声读物 评书 小说")
    super
  end

  def index
    seo_msg("有声读物 评书 小说", "抓取 有声读物 评书 小说", 
            "关注 聆听自己喜欢的有声读物 评书 小说")
    super
  end

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
