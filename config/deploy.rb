#encoding=utf-8
require 'bundler/capistrano' #添加之后部署时会调用bundle install， 如果不需要就可以注释掉
require "whenever/capistrano"

# 设置whenever
set :whenever_environment, defer { :production }
set :whenever_command, "bundle exec whenever"


# 设置path
# set :default_environment, { "PATH" => "/home/myliang/.rvm/gems/ruby-1.9.3-p392/bin:$PATH" }

set :application, "zhuata"
# set :repository,  "git@github.com:myliang/zhuata.git"
# set :repository,  "https://github.com/myliang/zhuata.git"
set :repository, "git://github.com/myliang/zhuata.git"
set :keep_releases, 5 #只保留5个备份

set :scm, :git
set :scm_username, "liangyuliang0335@gmail.com" # 资源库的用户名
set :scm_verbose, true
# set :scm_password, Proc.new { Capistrano::CLI.password_prompt('git Password: ') }
set :branch, "master"
set :deploy_via, :remote_cache

# 服务器
set :user, "myliang"   # 服务器 SSH 用户名
set :deploy_to, "/var/www/#{application}"
set :use_sudo, false
# permission
ssh_options[:forward_agent] = true

role :web, "115.100.249.73" # 前端 Web 服务器
role :app, "115.100.249.73" # Rails 应用服务器
role :db,  "115.100.249.73" , :primary => true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start  do ; end
  task :stop  do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Copy shared config files to current application."
  task :symlink_shared, :roles => :app do
	  # run "cp -f #{shared_path}/system/mongo.rb #{release_path}/config/initializers/mongo.rb"
    run "rm -rf #{release_path}/public/upload"
    run "ln -s /data/upload #{release_path}/public/upload"
  end
end

after 'deploy:create_symlink', 'deploy:symlink_shared'
# after 'deploy:create_symlink' do end
