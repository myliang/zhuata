require 'models/content_field'

class Blog

  include ContentField

  before_save do |model|
    model.state = ::ContentField::STATE_FINISHED
  end

end
