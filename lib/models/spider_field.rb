module SpiderField

  def self.included(mod)

    mod.key :url, String
    # 1 wait, 2 handling.. , 3 finished
    mod.key :state, Integer, default: 1

  end

end
