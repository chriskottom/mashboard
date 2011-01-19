# RVM bootstrap
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, "ree-1.8.7-2010.02@mashboard"

# Bundler bootstrap
require "bundler/capistrano"

# Main details
set :application, "mashboard"

# Server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
#set :deploy_via,  :remote_cache
set :deploy_to,   "/home/mashboard"
set :user,        "mashboard"
set :use_sudo,    false
server "chriskottom.com", :app, :web, :db, :primary => true

# Repository details
set :scm,         "git"
set :repository,  "git@github.com:chriskottom/mashboard.git"
set :branch,      "master"

# Tasks
namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
