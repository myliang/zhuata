#encoding: utf-8
FactoryGirl.define do
  factory :blog do
    text "ruby de 个性文章"
    title "ruby"
    tags "ruby,rails,language"
    user
  end

  factory :simple_blog, class: "Blog" do
    text "ruby on rails"
    title "ruby"
    tags "ruby,rails"
  end
end
