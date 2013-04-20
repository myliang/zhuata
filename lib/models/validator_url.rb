# encoding=utf-8
require 'spider/core'

class ValidatorUrl < ActionModel::Validator
  def validate(record)
    begin
      if record.class == Fiction
        Spider.parse(Spider::BOOK_HASH, record)
      elsif record.class == AudioBook
        Spider.parse(Spider::AUDIO_BOOK_HASH, record)
      end
    rescue
      record.errors[:url] = "解析地址错误!!!"
    end
  end
end
