class ScrapeTranscriptForVideo
    include Sidekiq::Worker

    def perform(video_id)
        video = Video.find(video_id)

        driver = Selenium::WebDriver.for :firefox
        driver.navigate.to "https://www.youtube.com/watch?v=#{video.youtube_id}"
        sleep(5)
        driver.find_element(:css, 'button[aria-label="More actions"]').click
        open_transcript_link = nil
        begin
            open_transcript_link = driver.find_element(:xpath, '//yt-formatted-string[text()="Open transcript"]')
        rescue => exception
            video.update!(status: :no_transcript)
        end 
        if open_transcript_link
            open_transcript_link.click
            sleep(5)

            transcript = driver.find_elements(:css, '.cue-group').map do |transcript_line|
                {
                    offset: transcript_line.find_element(:css, '.cue-group-start-offset').text,
                    text: transcript_line.find_element(:css, '.cues .cue').text
                }
            end
            video.update!(transcription: transcript, status: :transcription_scraped)
        else
            video.update!(status: :no_transcript)
        end

        driver.quit
    end
end
