# encoding: utf-8
class Content
  include MongoMapper::Document

  belongs_to :user

  many :comments, :as => :commentable
  key :tags, Array

  # update attibute add_tags and remove_tags is Array
  attr_accessor :old_tags

  timestamps!

  before_save do |model|
    model.tags = Content.tags_to_a(model.tags)
  end

  before_create do |model|
    Content.tag_class(model).update_counter(model.tags, 1)
  end

  before_update do |model|
    new_tags = model.tags
    old_tags = Content.tags_to_a(model.old_tags)
    Content.tag_class(model).update_counter(new_tags - old_tags, 1)
    Content.tag_class(model).update_counter(old_tags - new_tags, -1)
  end

  def tags_str
    tags.join(',')
  end

  class << self
    def tag_class(model)
      "#{model.class.name}Tag".constantize
    end
    def tags_to_a(tags)
      return tags if tags.empty?
      tags[0].split(/,|，/)
    end
  end

end
