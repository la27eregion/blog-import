require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

OSUNY = OsunyApi.new host: ENV['OSUNY_API_HOST'], token: ENV['OSUNY_API_TOKEN']
WEBSITE = OSUNY.communication.website ENV['OSUNY_WEBSITE_ID']

SOURCE_DIRECTORY = './converted_posts/'

def export_id(id)
  puts "Export id #{id}"
  export_path "#{SOURCE_DIRECTORY}#{id}.json"
end

def export_path(path)
  puts "Export path #{path}"
  file = File.read path
  WEBSITE.post.import file
end

def export_directory
  puts "Export directory"
  Dir["#{SOURCE_DIRECTORY}*.json"].each do |path|
    convert_path path
  end
end

ARGV.empty? ? export_directory
            : export_id(ARGV.first)