# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'syncedchurch'
set :deploy_user, 'eebulle'

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

set :server_files, [
  {
    name: 'nginx.conf.erb',
    path: "/etc/nginx/sites-enabled/#{fetch(:application)}",
  }
]

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :bundle_binstubs, nil

set :maintenance_template_path, "config/deploy/templates/maintenance.html.erb"

# puma
set :puma_threads, [4, 16]
set :puma_workers, 0
set :puma_init_active_record, true
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"

  # cleanup
  after :finishing, 'deploy:cleanup'

  before :started, 'deploy:setup_config'

  # reload nginx to it will pick up any modified vhosts from
  # setup_config
  after :setup_config, 'nginx:reload'

  # As of Capistrano 3.1, the `deploy:restart` task is not called
  # automatically.
  after :publishing, 'deploy:restart'
  
end