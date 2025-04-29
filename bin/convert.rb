require 'json'
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

IDENTIFIER = 'la27eregion-blog'
SOURCE_DIRECTORY = './imported_posts/'

def convert_id(id)
  puts "Convert id #{id}"
  path = "#{SOURCE_DIRECTORY}#{id}.json"
  convert_path path
end

def convert_path(path)
  puts "Convert path #{path}"
  file = File.read path
  data = JSON.parse file
  id = data['id']
  title = data['title']['rendered']
  slug = data['slug']
  summary = data['excerpt']['rendered']
  summary.gsub!('[&hellip;]', '...')
  created_at = data['date_gmt']
  migration_identifier = "#{IDENTIFIER}-post-#{id}"
  content = data['content']['rendered']
  hash = {
    migration_identifier: migration_identifier,
    title: title,
    slug: slug,
    summary: summary,
    created_at: created_at,
    blocks: [
      {
        template_kind: 'chapter',
        migration_identifier: "#{migration_identifier}-chapter",
        data: {
          text: content
        }
      }
    ]
  }
  File.write("converted_posts/#{id}.json", hash.to_json)
end

def convert_directory
  puts "Convert directory"
  Dir["#{SOURCE_DIRECTORY}*.json"].each do |path|
    convert_path path
  end
end

if ARGV.empty?
  convert_directory
else
  convert_id(ARGV.first)
end