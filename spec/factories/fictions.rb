# coding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fiction do
    title "盗墓笔记"
    text "我不知道我在那个地方待了多久，就那么呆呆地站着，看着这个背影。

　　我心说这算是怎么回事？他不是说要十年吗？他怎么就出来了？

　　难道他根本就是欺骗我？还是说，事情又有了新的变故？"
    author "南派三叔"
    url "http://www.daomubiji.com/"
  end
end
