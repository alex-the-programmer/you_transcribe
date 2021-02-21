class FindPopularVideosForChannel
    include Sidekiq::Worker

    def perform(channel_id)
        channel = Channel.find(channel_id)

        driver = Selenium::WebDriver.for :firefox
        driver.navigate.to channel.url

        # go to popular uploads
        driver.find_element(:xpath, '//span[text()="Popular uploads"]').click

        scroll = 0
        videos = nil
        last_videos_count = nil
        until videos&.count&.>=(1000) do
            sleep(5) # todo fix that only 90 vides make it to the DB due to scrollign 
            driver.execute_script("window.scrollTo(#{scroll}, #{scroll + 1000})")
            videos = driver.find_elements(:id, 'video-title')
            break if last_videos_count == videos.count
            last_videos_count = videos.count
            scroll = scroll + 1000
        end        
        
        driver.find_elements(:id, 'video-title').each do |video_link|
            youtube_id = video_link[:href].scan(/v=(.*)$/).last.first
            channel.videos.create_with(
                    name: video_link[:title],
                    slug: video_link[:title].parameterize,
                    status: :entered,
                    youtube_id: video_link[:href].scan(/v=(.*)$/).last.first
            ).find_or_create_by!(youtube_id: youtube_id)
        end
        driver.quit
    end
end
