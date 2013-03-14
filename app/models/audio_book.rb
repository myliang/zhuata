require 'models/content_field'
require 'models/spider_field'

class AudioBook

  include ::ContentField
  include ::SpiderField

  key :talker, String

  many :chapters


end
