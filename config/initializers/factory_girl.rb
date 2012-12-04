# module FactoryGirl.attributes_for
module FactoryGirl
  class << self
    def attributes_for_with(name, overrides = {})
      hash = {}
      attrs = attributes_for_without(name, overrides)
      puts "::::methods = #{attrs.methods}"
      hash.each_pair {|k, v| hash[k.to_s] = v}
      hash
    end
    alias_method :attributes_for_without, :attributes_for
    alias_method :attributes_for, :attributes_for_with
  end
end
