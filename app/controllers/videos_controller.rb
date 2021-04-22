class VideosController < ApplicationController
    def index
        @videos = Video
            .transcription_scraped
            .includes(:channel)

        @videos = @videos
            .where(channels: { slug: params[:channel_id]}) if params[:channel_id]

        if params[:query]
            # search_terms = params.require(:query).gsub(/[^0-9a-z ]/i, '').split(' ')[0..10]
            @videos = @videos
                .where("name ILIKE ?", "%#{params[:query]}%")
                .or(@videos
                    .where("transcription->>'title' ILIKE ?", "%#{params[:query]}%")    
                )
        end
            
        @videos = @videos.paginate(page: params[:page])
    end

    def show
        @video = Video
            .includes(:channel)
            .transcription_scraped
            .where(channels: { slug: params.require(:channel_id)})
            .find_by!(slug: params.require(:id))
    end
end
