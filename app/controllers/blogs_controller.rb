# encoding=utf-8
class BlogsController < ContentController

  def search
    seo_msg("个人博客查询结果", "博客 重要记录 技术 生活", "记录生活的点滴")
    super
  end

  def index
    seo_msg("个人博客首页", "博客 重要记录 技术 生活", "记录生活的点滴")
    super
  end

  def show
    seo_msg(@blog.title, "#{@blog.title} #{@blog.tags.join(' ')}", @blog.title)
    super
  end
end
