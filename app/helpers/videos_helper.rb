module VideosHelper
  def video_id(video)
    video.id.split('/').pop
  end
end
