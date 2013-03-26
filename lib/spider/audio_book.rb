# $LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))
Dir[File.expand_path('..', __FILE__) + '/audio_book/*.rb'].each do |file|
  require file
end

require File.expand_path('../http', __FILE__)

# puts File.join(__FILE__, '../audio_book')
# puts File.expand_path("..", __FILE__)
# puts File.dirname(__FILE__)
# $LOAD_PATH.unshift(File.dirname(__FILE__))

module Spider
  AUDIO_BOOK_HASH = {"5tps" => AudioBook::Fivetps}

  def self.parse(hash, record)
    domain_name = self.match(record.url, hash)
    if domain_name
      doc = Spider::Http.get(record.url)
      hash[domain_name].parse(doc, record)
    end
  end

  def self.read(hash, url)
    domain_name = self.match(record.url, hash)
    if domain_name
      doc = Spider::Http.get(record.url)
      hash[domain_name].read(doc)
    end
  end

  def self.match(url, hash)
    domain_name = /www\.([^\.]*)/.match(record.url)[1]
    unless hash.include?(domain_name)
      raise "not support this #{record.url} parse"
    end
    domain_name
  end

end

# puts Spider::AudioBook.parse("http://www.5tps.com", nil)
