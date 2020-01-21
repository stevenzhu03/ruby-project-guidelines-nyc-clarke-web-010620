#Yelp API setup from: https://github.com/Yelp/yelp-fusion/tree/master/fusion/ruby
require "json"
require "http"
require "optparse"
require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'


API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
API_KEY = ENV["6SkpxfmOou1-J6vUmaqqFPT4wtmjGiK1lsue9ZkqUCLqrv6-9k5Hxfhu1yTifwiRoXmF3QZVISyCmBaF0cW4IizoiRzmiBWb_yzkJVFmincW5Csi5YqlYBqx3zQnXnYx"]

DEFAULT_BUSINESS_ID = "yelp-san-francisco"
DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "New York, NY"
SEARCH_LIMIT = 5
