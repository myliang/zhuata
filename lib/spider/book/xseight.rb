module Spider
  module Book
    class Xseight
      class << self
        def parse(doc, record)
          record.author = doc.css('.authorbox a')[0].text
          record.title = doc.css('.booktitle h1 a')[0].text
          record.tags = doc.css('.bookinfo .info1 a')[0].text
          record.text = doc.css('#BookIntro')[0].text

          chapter_url = "http://www.xs8.cn#{doc.css('.readbtn a')[0].attr('href')}"
          chapter_doc = Spider::Http.get(chapter_url)
          chapter_doc.css('.mod_container ul li a').each_with_index do |link, index|
            # puts ":::tag_name=#{link.next_element.name}"
            break if link.next_element.name == "img"
            chapter = Chapter.new
            chapter.url = link.attr('href')
            chapter.title = link.content
            chapter.number = index
            record.chapters << chapter
          end
        end
        def read(doc)
          doc.css('.chapter_content')[0].text
        end
      end
    end
  end
end
