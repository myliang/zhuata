require 'models/content_field'
require 'models/spider_field'

class Fiction

  include ::ContentField
  include ::SpiderField

  key :author, String
  key :chapter_base_path, String

  many :chapters

end
