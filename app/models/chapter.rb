class Chapter
  include MongoMapper::EmbeddedDocument

  key :number, Integer, default: 1
  key :title, String, required: true
  # key :file_name, String

end
