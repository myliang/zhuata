require 'models/content_field'
require 'models/spider_field'
require 'spider/http'

class AudioBook

  include ::ContentField
  include ::SpiderField

  key :talker, String

  many :chapters

  before_create do |entity|
    entity.chapters = []

    # http://www.5tps.com
    doc = Spider::Http.get(url)
    entity.title = doc.css('#i>b>h1')[0].text
    doc.css('.ny_txt > ul').each do |ul|
      ps = ul.css('>span>p')
      entity.tags = ps[0].text.split(':')[1]
      entity.talker = ps[1].text.split(':')[1]
      entity.text = ul.css('>p')[0].text
    end
    doc.css('#bfdz ul li a:first-child').each do |link|
      chapter = Chapter.new
      chapter.url = "http://www.5tps.com#{link.attr('href')}"
      chapter.title = link.content
      chapter.number = chapter.title.scan(/\d+/)[0].to_i

      entity.chapters << chapter
    end
  end


end
