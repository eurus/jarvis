# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'
require 'capistrano3/unicorn'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'

# require 'capistrano/rbenv'
# require 'capistrano/chruby'
# require 'capistrano/rails/assets'
# require 'capistrano/passenger'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
