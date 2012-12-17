class Message
  include MongoMapper::Document

  belongs_to :to_user, class_name: 'User'
  belongs_to :from_user, class_name: 'User'

  key :text, String, required: true
  key :state, Integer, default: 0

  before_save :to_user_unread_messages_count

  private
  def to_user_unread_messages_count
    to_user.increment(unread_messages_count: 1)
    to_user.unread_messages_count += 1
  end

end
