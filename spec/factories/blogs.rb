#encoding: utf-8
FactoryGirl.define do
  factory :blog do
    text "ruby de 个性文章"
    title "ruby"
    tags "ruby,rails,language"
    association :user
  end
end
