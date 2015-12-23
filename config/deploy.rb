# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'syncedchurch'
set :deploy_user, 'eebulle'

set :url, 'gestion.eebulle.ch'

set :side_app, true

set :scm, "git"
set :repo_url, 'git@github.com:khcr/syncedchurch.git'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:deploy_user)}/apps/#{fetch(:application)}"

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, false

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_files, %w{config/database.yml config/secrets.yml config/puma.rb}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :bundle_binstubs, nil

set :maintenance_template_path, "config/deploy/templates/maintenance.html.erb"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  # cleanup
  after :finishing, "deploy:cleanup"
end
