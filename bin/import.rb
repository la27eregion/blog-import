require 'rubygems'
require 'bundler/setup'
require_relative 'wordpress_api'

Bundler.require(:default)
Dotenv.load

url = 'https://www.la27eregion.fr'
api = WordpressApi.new url
api.posts.each do |hash|
  File.write("imported_posts/#{hash['id']}.json", hash.to_json)
end