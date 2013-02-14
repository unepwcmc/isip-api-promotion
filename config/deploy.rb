require "bundler/capistrano"
# The name of your application.  Used for deployment directory and filenames
# and Apache configs. Should be unique on the Brightbox
gem 'brightbox', '>=2.3.9'
require 'brightbox/recipes'
require 'brightbox/passenger'

set :application, "isip-api-promo"

set :default_stage, 'staging'
require 'capistrano/ext/multistage'

# Target directory for the application on the web and app servers.
#set(:deploy_to) { File.join("", "home", user, application) }
set :deploy_to, "/home/rails/#{application}"
# URL of your source repository. By default this will just upload
# the local directory.  You should probably change this if you use
# another repository, like git or subversion.

set :repository,  "git@github.com:unepwcmc/isip-api-promotion.git"
set :branch, "master"
set :scm, :git
set :scm_username, "unepwcmc-read"
set :deploy_via, :remote_cache

# SSH options. The forward agent option is used so that loopback logins
# with keys work properly
# ssh_options[:forward_agent] = true

# Forces a Pty so that svn+ssh repository access will work. You
# don't need this if you are using a different SCM system. Note that
# ptys stop shell startup scripts from running.
default_run_options[:pty] = true

## Deployment settings
set :user, "rails"
set :rails_env, :production
