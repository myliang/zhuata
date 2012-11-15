#encoding: utf-8
FactoryGirl.define do
  factory :comment do
    text "写的不错，受用了"
    user

    factory :blog_comment do
      commentable factory: :blog
    end
  end
end
