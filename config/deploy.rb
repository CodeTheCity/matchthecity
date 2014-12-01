require 'rvm/capistrano'
require 'bundler/capistrano'

branch =  ENV["branch"] || 'master'

#general info
set :user, 'matchthecity'
set :application, "matchthecity"
set :domain, 'matchthecity.org'
set :applicationdir, "/home/#{user}/#{application}"
set :scm, 'git'
set :repository,  "git@github.com:CodeTheCity/matchthecity.git"
set :branch, branch
set :git_shallow_clone, 1
set :scm_verbose, true
set :deploy_via, :remote_cache
set :use_sudo, false

#RVM and bundler settings
set :bundle_cmd, "/home/#{user}/.rvm/gems/ruby-2.1.2@global/bin/bundle"
set :bundle_dir, "/home/#{user}/.rvm/gems/ruby-2.1.2/gems"
set :rvm_ruby_string, '2.1.2'
set :rack_env, :production
set :rvm_type, :user

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
#deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

#addition settings. mostly ssh
ssh_options[:forward_agent] = true
#ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]
#ssh_options[:paranoid] = false
default_run_options[:pty] = true
# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# As this isn't a rails app, we don't start and stop the app invidually
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    run "ls -al #{shared_path}/config"
    #put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"

    run "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  task :create_database, roles: :app do
    run_remote_rake "db:create"
  end

  task :migrate, roles: :app do
    run_remote_rake "db:migrate"
  end

  task :list_tasks, roles: :app do
    run_remote_rake "-T"
  end

  task :rebuild_all, roles: :app do
    run_remote_rake "import:rebuild_all"
  end

  task :rebuild_asv, roles: app do
    run_remote_rake "import:asv_classes_json"
    run_remote_rake "import:asv_swimming_classes_json"
  end

  task :rebuild_edinburgh, roles: :app do
    run_remote_rake "import_edinburgh:leisure_classes"
  end

  def run_remote_rake(rake_cmd)
    rake_args = ENV['RAKE_ARGS'].to_s.split(',')
    cmd = "cd #{fetch(:latest_release)} && #{fetch(:rake, "rake")} RACK_ENV=#{fetch(:rack_env, "production")} #{rake_cmd}"
    cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?
    run cmd
    set :rakefile, nil if exists?(:rakefile)
end
end