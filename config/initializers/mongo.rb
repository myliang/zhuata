MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "zhuata-#{Rails.env}"

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end

# paginate
module MongoMapper
  module Plugins
    module Pagination
      module ClassMethods
        def build_page_params(params)
          opt = {}
          params && params.kind_of?(Hash) && params.each do |k, v|
            opt[k.to_sym] = v unless ["controller", "action", "format", :controller, :action, :format].include?(k)
          end
          opt[:order] ||= :created_at.desc
          opt[:per_page] ||= 10
          opt[:page] ||= 1
          opt
        end

        def page(params)
          paginate(build_page_params(params))
        end
      end
    end

    # associations
    module Associations
      # add :counter_cache to associationOptions
      Base::AssociationOptions << :counter_cache
      class BelongsToAssociation

        def setup_with(model)
          setup_without(model)
          # counter_cache
          if counter_cache?

            model.after_create "after_create_#{name}_counter_cache".to_sym
            model.after_destroy "after_destroy_#{name}_counter_cache".to_sym

            model.class_eval <<-EVAL
            def after_create_#{name}_counter_cache
              return if #{name}.nil?
              counter_name = self.class.name.tableize + "_count"
              hash = {}
              hash[counter_name.to_sym] = 1
              #{name}.increment(hash)
              #{name}.send(counter_name + "=", #{name}.send(counter_name) + 1)
            end
            def after_destroy_#{name}_counter_cache
              return if #{name}.nil?
              counter_name = self.class.name.tableize + "_count"
              hash = {}
              hash[counter_name.to_sym] = 1
              #{name}.decrement(hash)
              #{name}.send(counter_name + "=", #{name}.send(counter_name) - 1)
            end
            EVAL
          end
        end

        alias_method :setup_without, :setup
        alias_method :setup, :setup_with

        def counter_cache?
          options[:counter_cache]
        end
        def counter_name
          "#{@model.to_s.tableize}_count"
        end
      end
    end
  end
end


