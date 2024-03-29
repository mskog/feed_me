# config valid only for current version of Capistrano
lock '3.4.1'

set :application, 'feed_me'
set :repo_url, 'git@github.com:mskog/feed_me.git'
set :branch, :master
set :deploy_to, '/var/www/feed_me'

set :user, :deployer

# For capistrano-db-tasks
set :db_local_clean, true
set :db_remote_clean, true
set :db_ignore_data_tables, ['credentials']

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
set :default_env, { path: "$PATH:/home/deployer/.nvm/v4.2.3/bin" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.2.0'
set :rbenv_command, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv"
set :rbenv_prefix, "#{fetch(:rbenv_command)} exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails foreman}
set :rbenv_roles, :all

set :bundle_jobs, 3

set :foreman_cmd, "#{fetch(:rbenv_command)} sudo foreman"

set :linked_files, %w{.env}
set :linked_dirs, %w{log uploads tmp/pids tmp/cache tmp/sockets vendor/bundle public/system node_modules}

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:app), in: :sequence, wait: 5 do
      execute "sudo service #{fetch(:application)} start || sudo service #{fetch(:application)} restart"
      execute "sudo passenger-config restart-app #{fetch(:deploy_to)}"
    end
  end
end

after 'deploy:publishing', 'deploy:restart'
