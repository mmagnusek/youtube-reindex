# encoding: utf-8

class VideoSearch

  include HTTParty
  
  format :xml
  
  class << self
    def new(params)
      hash     = self.get('http://gdata.youtube.com/feeds/api/videos', :query => params)

      VideoCollection.new(hash)
    end
  end
  
  
  def distance_from(video)
    self.distance_between(self,video)
  end
  
  # def self.get_top_favorites
  #   data = get('http://gdata.youtube.com/feeds/api/standardfeeds/top_favorites')
  #   if data['feed'] && data['feed']['entry']
  #     data['feed']['entry']
  #   else
  #     []
  #   end
  # end

  # 
  # def self.get_video(video_id)
  #   data = get("http://gdata.youtube.com/feeds/api/videos/#{video_id}")
  #   data['entry']
  # end
  
end