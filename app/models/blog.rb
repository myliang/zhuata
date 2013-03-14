require 'models/content_field'

class Blog

  include ContentField

  validates_presence_of :title, :text
  validates_length_of :title, maximum: 100
  validates_length_of :text, maximum: 500000

  before_save do |model|
    model.state = ::ContentField::STATE_FINISHED
  end

end
