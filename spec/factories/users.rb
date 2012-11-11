#encoding: utf-8
FactoryGirl.define do
  factory :user do
    name "myliang"
    password "vimvim"
    # encrypted_password "vimvim"
    email "liangyuliang0335@163.com"
    real_name "liang yuliang"
    location "北京"
    website "http://myliang.blog.com"
    bio "一个程序员"
  end
end
