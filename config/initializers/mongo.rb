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
        def page(opt)
          opt[:per_page] = 10 unless opt[:per_page]
          opt[:page] = 1 unless opt[:page]
          paginate(opt)
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
            # counter = "#{model.to_s.tableize}_count"
            params = {}
            params[counter_name] = 1

            puts "::::::::::name=#{name}"
            puts "::::::::::name=#{counter_name}"

            model.after_create :after_save_counter_cache
            model.after_destroy :after_destroy_counter_cache

            model.module_eval <<-EVAL
            def after_save_counter_cache
              association = self.#{name}
              return if association.nil?
              # association.class.key(:#{counter_name}, Integer, default: 0)
              association.increment(#{params})
            end
            def after_destroy_counter_cache
              return if self.#{name}.nil?
              self.#{name}.decrement(#{params})
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


