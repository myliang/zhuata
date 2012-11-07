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
  end
end
