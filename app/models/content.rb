# encoding: utf-8
class Content
  include MongoMapper::Document

  TEXT_CUT_LENGTH = 200

  belongs_to :user

  many :comments, :as => :commentable
  key :tags, Array
  key :read_counter, Integer, :default => 0

  # content
  key :title, String, :required => true
  key :text, String, :required => true

  # update attibute add_tags and remove_tags is Array
  attr_accessor :old_tags

  timestamps!

  def short_text
    # ary = text.scan(/([^<>]*)<br(\/)?>/)
    ary = text.scan(/>([^<>]*)</)
    content = ary.length > 0 ? ary.map{|ele| ele[0]}.join : text
    "#{content.length > TEXT_CUT_LENGTH ? content[0, TEXT_CUT_LENGTH] : content}..." 
  end

  def update_read_counter
    self.increment(:read_counter => 1)
  end

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
      suffix = model.instance_of?(Content) ? "" : model.class.name
      "#{suffix}Tag".constantize
    end
    def tags_to_a(tags)
      return tags if tags.empty?
      tags[0].split(/,|，/)
    end
  end

end
