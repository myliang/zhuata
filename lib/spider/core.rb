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
      doc = Iconv.conv('utf-8//IGNORE', 'GB2312', open(url).read)
      # puts ":::#{doc}"
      doc = Nokogiri::HTML(doc)
      # doc.encoding = 'utf-8'

      doc
    end
  end
end

# doc = Spider::Http.get('http://www.5tps.com/html/8923.html')
# doc.css('#bfdz ul li a').each do |ele|
#   puts "#{ele.content}:::#{ele.attr('href')}"
# end


