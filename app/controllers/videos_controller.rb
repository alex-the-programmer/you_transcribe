class VideosController < ApplicationController
    def show
        @video = Video
            .include(:channel)
            .where(channels: { slug: params[:channel_id]})
            .find_by!(slug: params[:id])
    end
end
