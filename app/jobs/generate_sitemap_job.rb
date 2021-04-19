class GenerateSitemapJob
    include Sidekiq::Worker
    include Rails.application.routes.url_helpers

    def perform
        # todo update secure: true
        sitemap = ::XmlSitemap::Map.new('youtranscribe.com', secure: false, home: false) do |m|
            Video.transcription_scraped.includes(:channel).each do |video|
                m.add(channel_video_path(video.channel.slug, video.slug), updated: video.updated_at, period: :monthly)
            end          
          end
        
        sitemap.render_to('public/sitemap.xml')
    end
end