require 'models/content_field'
require 'models/spider_field'
require 'spider/audio_book'

class AudioBook

  include ::ContentField
  include ::SpiderField

  key :talker, String

  many :chapters

  before_create do |entity|
    Spider.parse(Spider::AUDIO_BOOK_HASH, entity)
  end


end
