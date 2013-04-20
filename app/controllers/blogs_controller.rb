# encoding=utf-8
class BlogsController < ContentController

  def search
    seo_msg("个人博客搜索", "博客 重要记录 技术 生活", "记录生活的点滴")
    super
  end

  def index
    seo_msg("个人博客首页", "博客 重要记录 技术 生活", "记录生活的点滴")
    super
  end

end
