class DownloadVideoJob
    include Sidekiq::Worker

    def perfomr(id)
        video = Video.find(id)
        video.download_started!

        command = "youtube-dl '#{video.url}'"
        `command`

        video.download_completed!
    end
end
