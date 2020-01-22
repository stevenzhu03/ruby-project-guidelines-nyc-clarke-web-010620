#Yelp API setup from: https://github.com/Yelp/yelp-fusion/tree/master/fusion/ruby
# require "json"

require "http"
# require "optparse"
require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'



