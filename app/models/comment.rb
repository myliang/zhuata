class Comment
  include MongoMapper::Document

  key :text
  belongs_to :commentable, polymorphic: true# , :counter_cache => true
  belongs_to :user

  validates :commentable_id, presence: true

  # ensure_index [[:commentable_id, 1], [:user_id, 1]]

end
