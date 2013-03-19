require 'models/content_field'
require 'models/spider_field'
require 'spider/http'

class AudioBook

  include ::ContentField
  include ::SpiderField

  key :talker, String

  many :chapters

  before_create do |entity|
    doc = Spider::Http.get(url)
    doc.css('#bfdz ul li a').each do |link|
      "http://www.5tps.com#{link.attr('href')}"
      link.content
    end
  end


end
