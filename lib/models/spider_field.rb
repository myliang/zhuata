module SpiderField

  def self.included(mod)

    mod.key :url, String, unique: true

  end

end
