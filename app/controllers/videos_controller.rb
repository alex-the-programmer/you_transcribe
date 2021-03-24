class VideosController < ApplicationController
    def show
        @video = Video
            .includes(:channel)
            .transcription_scraped
            .where(channels: { slug: params[:channel_id]})
            .find_by!(slug: params[:id])
    end
end
