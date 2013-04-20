# encoding=utf-8
class WelcomeController < ApplicationController
  def index
    seo_msg("安静 清新 优美 去广告 欣赏喜欢的", 
           "有声读物 小说 评书 日志 等等",
           "这是一个抓取和分享数据的平台")

    @hot_tags = Tag.sort(:counter.desc).limit(10)
  end
end
