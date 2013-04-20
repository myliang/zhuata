# encoding=utf-8
# require 'models/validator_url'

module SpiderField

  def self.included(mod)

    mod.class_eval do

      key :url, String, unique: true

      # mod.validates_with ValidatorUrl
      validate :validator_url

      define_method :validator_url do
        begin
          if self.class == Fiction
            Spider.parse(Spider::BOOK_HASH, self)
          elsif self.class == AudioBook
            Spider.parse(Spider::AUDIO_BOOK_HASH, self)
          end
        rescue
          self.errors[:url] = "解析地址错误!!!"
          # self.errors.add :url, "解析地址错误!!"
        end
      end

    end

  end

end
