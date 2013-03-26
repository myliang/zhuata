module Spider
  module AudioBook
    class Fivetps
      def self.parse(doc, record)
        record.title = doc.css('#i>b>h1')[0].text
        doc.css('.ny_txt > ul').each do |ul|
          ps = ul.css('>span>p')
          record.tags = ps[0].text.split(':')[1]
          record.talker = ps[1].text.split(':')[1]
          record.text = ul.css('>p')[0].text
        end
        doc.css('#bfdz ul li a:first-child').each do |link|
          chapter = Chapter.new
          chapter.url = "http://www.5tps.com#{link.attr('href')}"
          chapter.title = link.content
          chapter.number = chapter.title.scan(/\d+/)[0].to_i

          record.chapters << chapter
        end
      end

      def self.read(doc)
        embed = doc.css('embed')[0]
        embed['src']
      end
    end
  end
end

