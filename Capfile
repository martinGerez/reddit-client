require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git

require 'capistrano/rails'
require 'capistrano/rvm'
require 'capistrano/rails/console'
require 'capistrano/rails_tail_log'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
