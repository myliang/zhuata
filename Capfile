load 'deploy'
# Uncomment if you are using Rails' asset pipeline
    load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks

# cap -vT
# cap deploy:setup #建立部署路径
# cap deploy:update #部署
# cap deploy:start    #启动服务
# cap deploy:stop   #停止服务
# cap deploy:restart #重启服务
# cap assets:cleanup           #
# cap assets:precompile        #
# cap assets:redigest          #
# cap bundle:install           # Install the current Bundler environment.
# cap custom_symlink           #
# cap deploy                   # Deploys your project.
# cap deploy:assets:clean      # Run the asset clean rake task.
# cap deploy:assets:precompile # Run the asset precompilation rake task.
# cap deploy:assets:symlink    # [internal] This task will set up a symlink to ...
# cap deploy:check             # Test deployment dependencies.
# cap deploy:cleanup           # Clean up old releases.
# cap deploy:cold              # Deploys and starts a `cold' application.
# cap deploy:finalize_update   # [internal] Touches up the released code.
# cap deploy:migrate           # Run the migrate rake task.
# cap deploy:migrations        # Deploy and run pending migrations.
# cap deploy:pending           # Displays the commits since your last deploy.
# cap deploy:pending:diff      # Displays the `diff' since your last deploy.
# cap deploy:restart           #
# cap deploy:rollback          # Rolls back to a previous version and restarts.
# cap deploy:rollback:cleanup  # [internal] Removes the most recently deployed ...
# cap deploy:rollback:code     # Rolls back to the previously deployed version.
# cap deploy:rollback:revision # [internal] Points the current symlink at the p...
# cap deploy:setup             # Prepares one or more servers for deployment.
# cap deploy:start             #
# cap deploy:stop              #
# cap deploy:symlink           # Updates the symlink to the most recently deplo...
# cap deploy:update            # Copies your project and updates the symlink.
# cap deploy:update_code       # Copies your project to the remote servers.
# cap deploy:upload            # Copy files to the currently deployed version.
# cap deploy:web:disable       # Present a maintenance page to visitors.
# cap deploy:web:enable        # Makes the application web-accessible again.
# cap invoke                   # Invoke a single command on the remote servers.
# cap precompile_trace         #
# cap setup_file_tree          #
# cap shell                    # Begin an interactive Capistrano session.
# cap whenever:clear_crontab   # Clear application's crontab entries using When...
# cap whenever:update_crontab  # Update application's crontab entries using Whe...
