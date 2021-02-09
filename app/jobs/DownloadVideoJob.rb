class DownloadVideoJob
    include Sidekiq::Worker

    def perfomr(id)
        video = Video.find(id)
        video.download_started!

        command = "youtube-dl --id --write-auto-sub '#{video.url}'" # consider -o for output tempate, trying annotations , subtitles
        # later --extract-audio to extract audio only 
        `command`

        video.download_completed!
    end
end
