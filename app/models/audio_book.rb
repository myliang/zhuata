require 'models/content_field'
require 'models/spider_field'
require 'spider/core'

class AudioBook

  include ::ContentField
  include ::SpiderField

  key :talker, String

  many :chapters

end
