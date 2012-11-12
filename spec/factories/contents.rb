#encoding: utf-8
FactoryGirl.define do
  factory :content do
    title "十五分钟介绍 Redis数据结构"
    new_tags "ruby,rails，zhongwen"
    association :user
    text "下面是一个对Redis官方文档《A fifteen minute introduction to Redis data types》一文的翻译，如其题目所言，此文目的在于让一个初学者能通过15分钟的简单学习对Redis的数据结构有一个了解。Redis是一种面向“键/值”对类型数据的分布式NoSQL数据库系统，特点是高性能，持久存储，适应高并发的应用场景。它起步较晚，发展迅速，目前已被许多大型机构采环境:ruby 1.9.2有这样一个需求， 给你 任意一个字符串，把它转化为类,网上大多数的 解决办法是 下面三种:Kernel.const_get(:User) # Object.const_get(:User) eval(’User’) ‘User’.constantize但是上面三种方法, 这个 User 事先必须是初始化的,不然会报错，如下:Object.const_get(:User"
  end
end
