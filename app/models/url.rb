class Url
  include MongoMapper::Document

  key :address, String
  key :title, String

end
