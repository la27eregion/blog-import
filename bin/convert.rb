require 'json'
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

class Analyzer
  IDENTIFIER = 'la27eregion-blog'

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def id
    data['id']
  end

  def migration_identifier
    "#{IDENTIFIER}-post-#{id}"
  end

  def summary
    raw = html.children.first.to_s
    raw.gsub('<p><em>', '<p>')
       .gsub('</em></p>', '</p>')
  end

  def image
    html.css('img').first['src']
  end

  def hash
    {
      migration_identifier: migration_identifier,
      created_at: data['date_gmt'],
      updated_at: data['modified_gmt'],
      category_ids: [
        'ac8e2057-df7e-4d88-8419-43907deba97a'
      ],
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
  end

  def blocks
    @chapter_index = 0
    @image_index = -1
    @video_index = 0
    @embed_index = 0
    @blocks = []
    @chapter_content = ''
    html.children.each_with_index do |child, index|
      # First paragraph is summary
      next if index.zero?      
      case child.name
      when 'p'
        if child.to_s.include?('www.youtube.com')
          flush_chapter
          add_video child.children.first['src']
        elsif child.to_s.include?('<iframe')
          flush_chapter
          add_embed child.children.first.to_s
        else
          @chapter_content += child.to_s
        end
      when 'figure'
        # First image is featured_image
        if @image_index == -1
          @image_index += 1
          next
        end
        flush_chapter
        add_image child.children.first['href']
      end
    end
    flush_chapter
    @blocks
  end

  protected

  def position
    @blocks.count
  end

  def flush_chapter
    add_chapter @chapter_content if @chapter_content != ''
  end

  def add_chapter(text)
    clean_text = text.gsub(" class=\"spip_out\"", '')
                    .gsub(" class=\"spip\"", '')
    @blocks << {
      template_kind: 'chapter',
      migration_identifier: "#{migration_identifier}-chapter-#{@chapter_index}",
      position: position,
      data: {
        text: clean_text
      }
    }
    @chapter_content = ''
    @chapter_index += 1
  end

  def add_image(url)
    return if url.nil?
    @blocks << {
      template_kind: 'image',
      migration_identifier: "#{migration_identifier}-image-#{@image_index}",
      position: position,
      data: {
        url: url
      }
    }
    @image_index += 1
  end

  def add_video(url)
    return if url.nil?
    url = url.gsub('//www.youtube.com', 'https://www.youtube.com')
    @blocks << {
      template_kind: 'video',
      migration_identifier: "#{migration_identifier}-video-#{@video_index}",
      position: position,
      data: {
        url: url
      }
    }
    @video_index += 1
  end

  def add_embed(code)
    @blocks << {
      template_kind: 'video',
      migration_identifier: "#{migration_identifier}-embed-#{@embed_index}",
      position: position,
      data: {
        code: code
      }
    }
    @embed_index += 1
  end

  def file
    @file ||= File.read path
  end

  def data
    @data ||= JSON.parse file
  end

  def content
    data['content']['rendered']
  end

  def html
    @html ||= Nokogiri::HTML::DocumentFragment.parse content
  end
end

SOURCE_DIRECTORY = './imported_posts/'

def convert_id(id)
  puts "Convert id #{id}"
  path = "#{SOURCE_DIRECTORY}#{id}.json"
  convert_path path
end

def convert_path(path)
  puts "Convert path #{path}"
  analyzer = Analyzer.new path
  puts JSON.pretty_generate(analyzer.hash)
  File.write("converted_posts/#{analyzer.id}.json", analyzer.hash.to_json)
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