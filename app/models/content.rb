# encoding: utf-8
class Content
  include MongoMapper::Document

  belongs_to :user

  many :comments, :as => :commentable
  key :tags, Array
  key :read_counter, Integer, :default => 0

  # content
  key :title, String, :required => true
  key :text, String, :required => true

  # update attibute add_tags and remove_tags is Array
  attr_accessor :new_tags

  timestamps!

  def update_read_counter
    self.increment(:read_counter => 1)
  end

  before_save do |model|
    model.tags = Content.tags_to_a(model.new_tags)
  end

  before_create do |model|
    Content.tag_class(model).update_counter(model.tags, 1)
  end

  before_update do |model|
    old_tags = model.tags
    new_tags = Content.tags_to_a(model.new_tags)
    Content.tag_class(model).update_counter(new_tags - old_tags, 1)
    Content.tag_class(model).update_counter(old_tags - new_tags, -1)
  end

  class << self
    def tag_class(model)
      suffix = model.instance_of?(Content) ? "" : model.class.name
      "#{suffix}Tag".constantize
    end
    def tags_to_a(tags)
      return [] if tags.nil?
      tags.split(/,|，/)
    end
  end

end
