class GenerateSitemapJob
    include Sidekiq::Worker
    include Rails.application.routes.url_helpers

    def perform
        sitemap = ::XmlSitemap::Map.new('youtranscribe.com', secure: true, home: false) do |m|
            Video.transcription_scraped.includes(:channel).each do |video|
                m.add(channel_video_path(video.channel.slug, video.slug), :updated => video.updated_at)
            end          
          end
        
        sitemap.render_to('sitemap.xml')
    end
end