# encoding: utf-8

class VideoSearch

  include HTTParty
  
  format :xml
  
  class << self
    def new(params)
      params.merge!({:'max-results' => 10})
      hash = self.get('http://gdata.youtube.com/feeds/api/videos', :query => params)
      VideoCollection.new(hash)
    end
    
    def get_video(video_id)
      hash = self.get("http://gdata.youtube.com/feeds/api/videos/#{video_id}")
    end
  end
end