class Tag
  include MongoMapper::Document

  key :name, String
  key :counter, Integer, default: 1

  ensure_index :name

  class << self
    def update_counter(names, counter)
      names = [names] if names.kind_of? String
      raise ArgumentError.new("first argument should be Array or String") unless names.kind_of? Array
      names.each do |name|
        params = {name: name}
        tag = first(params)
        if tag.nil?
          new(params).save
        else
          tag.increment(counter: counter)
        end
      end
    end
  end

end
