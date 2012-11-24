class Reply
  include MongoMapper::EmbeddedDocument

  key :text, String, presence: true
  key :children, Array

  belongs_to :user

end
