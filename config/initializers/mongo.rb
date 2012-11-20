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
          puts ":::::class==#{model}"
          puts ":::::options==#{options.to_json}"
          puts "::counter_cache::#{options[:counter_cache]}"
          # counter_count
          if counter_cache?
            counter = "#{model.to_s.tableize}_count"
            puts ":::#{counter}::: field::: #{type_key_name}"
            puts ":::klass:::#{model.associations[name.inspect]}"
            klass.key counter, default: 0
            # add after save method increment
            model.after_save do 
              send(name).send :increment, counter.to_sym, 1
              # send(name).send "#{counter}=", (model.send counter + 1)
            end
            model.after_destroy do
              send(name).send :decrement, counter.to_sym, 1
              # send(name).send "#{counter}=", (model.send counter - 1)
            end
          end
        end

        alias_method :setup_without, :setup
        alias_method :setup, :setup_with

        def counter_cache?
          options[:counter_cache]
        end
      end
    end
  end
end


