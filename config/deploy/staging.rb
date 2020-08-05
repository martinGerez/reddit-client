set :rails_env, :staging

set :application, 'reddit_test'

# Branch and folder
set :branch, 'dev'
set :deploy_to, "/home/deploy/#{fetch(:application)}"

# User and server
server '172.105.153.177', user: 'deploy', roles: %w[app web db]

# default env to rails:console
set :console_env, :staging
