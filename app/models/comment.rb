class Comment
  include MongoMapper::Document

  key :text, String, required: true

  many :replies

  timestamps!

  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :user, counter_cache: true

  validates :commentable_id, presence: true

  ensure_index [[:commentable_id, 1], [:user_id, 1]]

end
