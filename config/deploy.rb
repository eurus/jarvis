# config valid only for current version of Capistrano
lock '3.4.0'
app_name = "eurus-jarvis"
set :application, "#{app_name}"
set :repo_url, 'git@your_repo.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/#{app_name}"
set :deploy_via, :remote_cache

set :rvm_type, :system
set :default_env, { rvm_bin_path: '/usr/local/rvm/bin/ '}
# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, false
# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/assets','public/uploads','public/css')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5
set :rails_env, 'production'
set :migration_role, 'app'            # Defaults to 'db'
set :conditionally_migrate, true           # Defaults to false. If true, it's skip migration if files in db/migrate not modified


namespace :deploy do

  after :restart, :clear_cache do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc "Start the Unicorn process when it isn't already running."
  task :start do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      invoke 'unicorn:start'
    end
  end

  desc "Initiate a rolling restart by telling Unicorn to start the new application code and kill the old process when done."
  task :restart do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      invoke 'unicorn:restart'
    end
  end

  desc "Stop the application by killing the Unicorn process"
  task :stop do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      invoke 'unicorn:stop'
    end
  end

  desc "Assets Precompile On Server"
  task :asp do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, "rake assets:precompile"
        end
      end
    end
  end

  desc "Redeploy the whole application"
  task :redeploy do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      # invoke 'unicorn:stop'
    end
  end

  after 'deploy', "deploy:migrate"
  # after 'deploy:migrate', "deploy:china_region"
  after 'deploy:migrate','deploy:asp'
  after 'deploy:redeploy',"deploy"
  after 'deploy:redeploy',"stop"
  after 'deploy:redeploy',"start"
end

# whenever task namespane
# start whenever task by
# cap production whenever:deploy
# clean the whenever task by
# cap production whenever:clean
namespace :whenever do
  desc "start whenever task for the cron job"
  task :deploy do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      within "#{current_path}" do
        with rails_env: fetch(:rails_env) do
          execute :bundle, :exec, "whenever -i"
        end
      end
    end
  end

  desc "clean whenever task for the cron job"
  task :clean do
    on roles(:app), in: :groups, limit: 3, wait: 10 do
      within "#{current_path}" do
        with rails_env: fetch(:rails_env) do
          execute "crontab -r"
        end
      end
    end
  end
end

###使用方法###
## 默认任务
# cap production deploy && cap production deploy:start
# => 运行网站基础服务
# cap production deploy:redeploy
###使用方法###
