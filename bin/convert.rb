require 'json'
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

migration_identifier = 'la27eregion-blog'

Dir["./imported_posts/*.json"].each do |path|
  file = File.read path
  data = JSON.parse file
  id = data['id']
  title = data['title']['rendered']
  slug = data['slug']
  summary = data['excerpt']['rendered']
  summary.gsub!('[&hellip;]', '...')
  created_at = data['date_gmt']
  post_identifier = "#{migration_identifier}-post-#{id}"
  content = data['content']['rendered']
  hash = {
    migration_identifier: post_identifier,
    title: title,
    slug: slug,
    summary: summary,
    created_at: created_at,
    blocks: [
      {
        template_kind: 'chapter',
        migration_identifier: "#{post_identifier}-chapter",
        data: {
          text: content
        }
      }
    ]
  }
  File.write("converted_posts/#{id}.json", hash.to_json)
end
