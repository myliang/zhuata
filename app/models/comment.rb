class Comment
  include MongoMapper::Document

  key :text
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

end
