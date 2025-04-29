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
  created_at = data['date_gmt']
  migration_identifier = "#{IDENTIFIER}-post-#{id}"
  content = data['content']['rendered']
  html = Nokogiri::HTML::DocumentFragment.parse content
  summary = extract_summary html
  image = extract_image html
  blocks = parse_content(html, migration_identifier)
  hash = {
    migration_identifier: migration_identifier,
    created_at: data['date_gmt'],
    updated_at: data['modified_gmt'],
    localizations: {
      fr: {
        migration_identifier: "#{migration_identifier}-fr",
        aliases: [
          "/#{data['slug']}"
        ],
        title: data['title']['rendered'],
        slug: data['slug'],
        summary: summary,
        featured_image: {
          url: image
        },
        published: true,
        published_at: data['date_gmt'],
        created_at: data['date_gmt'],
        updated_at: data['modified_gmt'],
        blocks: blocks
      }
    }
  }
  puts JSON.pretty_generate(hash)
  File.write("converted_posts/#{id}.json", hash.to_json)
end

def extract_summary(html)
  raw = html.children.first.to_s
  raw.gsub('<p><em>', '<p>')
     .gsub('</em></p>', '</p>')
end

def extract_image(html)
  html.css('img').first['src']
end

def parse_content(html, migration_identifier)
  position = 0
  chapter_index = 0
  image_index = 0
  blocks = []
  html.children.each_with_index do |child, index|
    next if index.zero?
    case child.name
    when 'p'
      blocks << {
        template_kind: 'chapter',
        migration_identifier: "#{migration_identifier}-chapter-#{chapter_index}",
        position: position,
        data: {
          text: child.to_s
        }
      }
      position += 1
      chapter_index += 1
    when 'figure'
      if image_index.zero?
        image_index += 1
        next
      end
      blocks << {
        template_kind: 'image',
        migration_identifier: "#{migration_identifier}-image-#{image_index}",
        position: position,
        data: {
          url: child.children.first['href']
        }
      }
      position += 1
      image_index += 1
    end
  end
  blocks
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