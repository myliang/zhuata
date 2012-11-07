class Tag
  include MongoMapper::Document

  key :name, String
  key :counter, Integer, :default => 1

  ensure_index :name

  class << self
    def update_counter(names, v)
      names.each do |name|
        params = {:name => name}
        tag = first(params)
        if tag.nil?
          new(params).save
        else
          tag.increment(:counter => v)
        end
      end
    end
  end

end
