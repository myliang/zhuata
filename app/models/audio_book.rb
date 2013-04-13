require 'models/content_field'
require 'models/spider_field'
require 'spider/core'

class AudioBook

  include ::ContentField
  include ::SpiderField

  key :talker, String

  many :chapters

  before_create do |record|
    Spider.parse(Spider::AUDIO_BOOK_HASH, record)
  end


end
