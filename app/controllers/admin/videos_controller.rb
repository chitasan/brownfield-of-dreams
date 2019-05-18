# frozen_string_literal: true

module Admin
  class VideosController < BaseController
    # def edit
    #   @video = Video.find(params[:video_id])
    # end

    # def update
    #   video = Video.find(params[:id])
    #   video.update!(video_params)
    # end

    def create
      begin
        tutorial  = Tutorial.find(params[:tutorial_id])
        thumbnail = YouTube::Video.by_id(video_params[:video_id]).thumbnail
        video     = tutorial.videos.new(
          video_params.merge(thumbnail: thumbnail)
        )

        video.save

        flash[:success] = "Successfully created video."
      rescue StandardError # Sorry about this.
        # We should get more specific instead of swallowing all errors.
        # flash[:error] = "Unable to create video."
        # Need to test this
      end

      redirect_to edit_admin_tutorial_path(id: tutorial.id)
    end

    private

    def video_params
      params.require(:video).permit(:title,
                                    :description,
                                    :video_id,
                                    :thumbnail,
                                    :position)
    end
  end
end
