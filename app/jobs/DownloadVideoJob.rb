class DownloadVideoJob
    include Sidekiq::Worker

    def perform(id)
        video = Video.find(id)
        video.download_started!

        command = "youtube-dl --id --write-auto-sub '#{video.watch_url}'" # consider -o for output tempate, trying annotations , subtitles
        # later --extract-audio to extract audio only 
        `command`

        video.update(transcription: process_subtitiles(video))

        video.download_completed!
    rescue
        video.download_error!
        raise
    end

    def process_subtitiles(video)
        filename = "#{video.youtube_id}.en.vtt"
        is_even_line = false
        subtitiles = ""
        if File.exists?(filename)
            File.open(filename) do |file|
                file.each_line do |line|
                    unless line.include?('-->') || line.include?('<') || line.blank? || line.include?('WEBVTT') || line.include?('Kind: captions') || line.include?('Language: en')
                        subtitiles << line if is_even_line
                        is_even_line = !is_even_line
                    end
                end
            end
        end
        
        File.write("#{video.youtube_id}.txt", subtitiles)

        subtitiles.gsub(/\n/, '<br>')
    end
end
