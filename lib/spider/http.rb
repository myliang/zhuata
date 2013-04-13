# require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'iconv'

module Spider
  class Http
    # opt = [{reg: '', callback}]
    def self.get(url, opt = {})
      # uri = URI(url)
      # response = Net::HTTP.get(uri)
      # puts ":::::#{response}"
      content = open(url).read
      charset = /charset=([^\"]*)/.match(content)[1]
      if charset.downcase == "gb2312"
        content = Iconv.conv('utf-8//IGNORE', 'GB2312', content)
      end
      # puts ":::#{doc}"
      doc = Nokogiri::HTML(content)
      # doc.encoding = 'utf-8'

      doc
    end
  end
end

doc = Spider::Http.get('http://www.5tps.com/html/8923.html')
doc = Spider::Http.get('http://www.xs8.cn/book/130726/readbook.html')
# doc.css('#bfdz ul li a').each do |ele|
#   puts "#{ele.content}:::#{ele.attr('href')}"
# end


