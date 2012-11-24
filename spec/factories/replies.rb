# encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reply do
    sequence(:text){ |n| " 第#{n}个问题，是这样的，没有问题" }
    user
  end
end
