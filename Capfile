require 'dotenv'
Dotenv.load
puts ENV['REDIS_URL']

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano-db-tasks'

Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }

