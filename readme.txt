# spec
1 rails g rspec:install
2 rspec config
3 rake spec (run test)

# spork
1 add text "gem 'devise'" to Gefile
1 spork --bootstrap
2 spork (runing)

# bootstrap
gem 'twitter-bootstrap-rails'
rails g bootstrap:install
rails g bootstrap:layout [LAYOUT_NAME] [*ﬁxed or ﬂuid]

# devise
1 add text "gem 'devise'" to Gemfile
1 add text "gem 'mm-devise'" to Gemfile
2 rails g devise:install
# 如果使用Mongodb数据库，那么需要在生成devise.rb中
# 执行下一步将自动添加一下信息：
# require 'devise/orm/mongo_mapper'
3 rails g mongo_mapper:devise User
4 rails g devise:views users

# ....
