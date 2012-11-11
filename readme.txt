# spec
1 rails g rspec:install
2 rspec config
3 rake spec (run test)

# spork
1 add text "gem 'devise'" to Gefile
1 spork --bootstrap
2 spork (runing)

# factory_girl_rails
1 add text "gem 'factory_girl_rails'" to Gefile

#让devise支持rspec测试

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


# spork spec config
上面的命令，其实就是修改 your_app/spec/spec_helper.rb，在此文件的头部添加了两个方法：Spork.prefork（只在启动时执行一次） 和 Spork.each_run（每次被RSpec调用时执行）。

　 继续修改此rspec配置文件，将rspec的内容移入prefork方法内，并在each_run方法内添加每次需重新加载的文件。文件内容大致如下：

?
# -*- encoding : utf-8 -*-
require 'spork'
 
Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("http://www.cnblogs.com/config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
 
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
 
  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
 
    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
 
    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
 
    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  end
 
end
 
Spork.each_run do
  # This code will be run each time you run your specs.
  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/app/**/**.rb"].each { |f| load f }
end
　　修改rspec配置文件(your_app/.rspec)，告诉它我们用的是spork，添加代码：

--drb
　　一般修改后完整的代码为：

--colour
--drb

# ....
