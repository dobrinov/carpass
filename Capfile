require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'new_relic/recipes'
require "whenever/capistrano"

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
