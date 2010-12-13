# encoding: utf-8

class YoutubeSearch

  include HTTParty
  
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
    data = get('http://gdata.youtube.com/feeds/api/videos', :query => {:q => keyword, :orderby => 'viewCount' })
    if data['feed'] && data['feed']['entry']
      data['feed']['entry']
    else
      []
    end
  end
  
end