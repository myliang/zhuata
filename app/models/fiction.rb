require 'models/spider_field'
require 'models/content_field'

class Fiction 

  include ContentField
  include SpiderField

  key :author, String, required: true

  many :chapters

end
