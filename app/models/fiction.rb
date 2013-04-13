require 'models/content_field'
require 'models/spider_field'
require 'spider/core'

class Fiction

  include ::ContentField
  include ::SpiderField

  key :author, String
  key :chapter_base_path, String

  many :chapters

  before_create do |record|
    Spider.parse(Spider::BOOK_HASH, record)
  end


end
