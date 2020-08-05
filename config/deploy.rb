lock '~> 3.14.1'

set :repo_url, 'git@github.com:martinGerez/reddit-client.git'

# RVM Gemset
set :rvm_map_bins, %w{gem rake ruby rails bundle}
set :rvm_ruby_version, '2.6.3@reddit-client'

set :keep_releases, 5

# yarn
set :yarn_target_path, -> { release_path }

# Symlinks
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'public/packs', 'node_modules', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
append :linked_files, 'config/master.key', 'config/database.yml'

# SSH
set :ssh_options, forward_agent: true, port: 22

before 'deploy:assets:precompile', 'deploy:yarn_install'
namespace :deploy do
  desc 'Run rake yarn install'
  task :yarn_install do
    on roles :web do
      within release_path do
        execute "cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional"
      end
    end
  end
end

namespace :deploy do
  # Restart passenger
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
