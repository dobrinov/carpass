lock '3.3.5'

set :application, 'autobook'
set :repo_url, 'git@github.com:dobrinov/autobook.git'

# Deployment configuration
set :deploy_user, 'deploy'
set :deploy_to, "/home/#{fetch(:deploy_user)}/#{fetch(:application)}"
set :keep_releases, 5

# Rbenv configuration
set :rbenv_type, :user
set :rbenv_ruby, "2.3.0"
set :rbenv_custom_path, "/home/#{fetch(:deploy_user)}/.rbenv"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

# Linked dirs
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}
# set :linked_files, %w{.rbenv-vars}

set :format, :pretty
set :log_level, :debug
set :pty, true

namespace :deploy do
end
