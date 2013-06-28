$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

set :application, "lashes"
set :scm, :git
set :repository, "git://github.com/MissionalDigerati/cddn.git"
set :branch, "dev_server"

set :user, "md"
set :deploy_to, "/var/www/cddn"
set :deploy_via, :remote_cache
set :use_sudo, false
set :group_writable, false


# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "naysayer.no-ip.biz"                          # Your HTTP server, Apache/etc
role :app, "naysayer.no-ip.biz"                          # This may be the same as your `Web` server
role :db,  "naysayer.no-ip.biz", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
