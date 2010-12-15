# encoding: utf-8

class YoutubeSearch

  include HTTParty
  
  KMS_PER_MILE = 1.609
  EARTH_RADIUS_IN_MILES = 3963.19
  EARTH_RADIUS_IN_KMS = EARTH_RADIUS_IN_MILES * KMS_PER_MILE
  
  format :xml
  
  def self.get_top_favorites
    data = get('http://gdata.youtube.com/feeds/api/standardfeeds/top_favorites')
    if data['feed'] && data['feed']['entry']
      data['feed']['entry']
    else
      []
    end
  end
  
  def self.get_by_keyword(keyword)
    data = get('http://gdata.youtube.com/feeds/api/videos', :query => {:q => keyword, :orderby => 'relevance' })
    if data['feed'] && data['feed']['entry']
      data['feed']['entry']
    else
      []
    end
  end
  
  def self.get_video(video_id)
    data = get("http://gdata.youtube.com/feeds/api/videos/#{video_id}")
    data['entry']
  end
  
  def self.distance_between(from, to)
    from = ll from
    to   = ll to
    # return 0.0 if from == to # fixes a "zero-distance" bug

    begin
      EARTH_RADIUS_IN_KMS * 
          Math.acos( Math.sin(deg2rad(from[:lat])) * Math.sin(deg2rad(to[:lat])) + 
          Math.cos(deg2rad(from[:lat])) * Math.cos(deg2rad(to[:lat])) * 
          Math.cos(deg2rad(to[:lng]) - deg2rad(from[:lng])))
    rescue Errno::EDOM
      0.0
    end
  end
  
  def self.ll(video)
    pos = video['georss:where']['gml:Point']['gml:pos'].split();
    {:lat => pos.first, :lng => pos.last}
  end
  
  def self.deg2rad(degrees)
    degrees.to_f / 180.0 * Math::PI
  end

  
end