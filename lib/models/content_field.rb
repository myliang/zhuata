# coding: utf-8
module ContentField
  def self.included(mod)
    # puts ":::::::mod.name==#{mod}"
    # mod.send :include, ::MongoMapper::Document
    mod.class_eval do 

      include ::MongoMapper::Document

      belongs_to :user, counter_cache: true

      many :comments, as: :commentable
      key :tags, Array
      key :read_count, Integer, default: 0
      key :comments_count, Integer, default: 0

      # content
      key :title, String, required: true, length: {maximum: 100}
      key :text, String, required: true, length: {maximum: 500000}

      # update attibute add_tags and remove_tags is Array
      attr_accessor :new_tags

      timestamps!

      # full text index
      searchable do
        text :title, stored: true
        time :created_at
      end

      ensure_index :user_id

      before_save do |model|
        model.tags = model.new_tags_to_a
      end

      before_create do |model|
        model.tag_class.update_counter(model.tags, 1)
      end

      before_update do |model|
        old_tags = model.tags
        new_tags = model.new_tags_to_a
        model.tag_class.update_counter(new_tags - old_tags, 1)
        model.tag_class.update_counter(old_tags - new_tags, -1)
      end

      # instance methods
      define_method :update_read_count do
        self.increment(read_count: 1)
      end

      define_method :tag_class do
        suffix = self.class.name
        "#{suffix}Tag".constantize
      end

      define_method :new_tags_to_a do
        return [] if new_tags.nil?
        new_tags.split(/,|，/)
      end

    end
  end

end
