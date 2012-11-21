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
            model.after_save do |m|
              association = m.send(name)
              association.class.key counter_name unless association.class.key?(counter_name)

              m.send(name).increment("#{counter_name}": 1)
            end
            model.after_destroy do |m|
              m.send(name).decrement("#{counter_name}": 1)
            end
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


