# encoding: utf-8

require 'ostruct'

module VideoCollection

  DISTANCE = 0
  DURATION = 1
  PUBLISHED = 2
  RATING = 3
  VIEWS = 4

  def self.new(hash, params = {})
    hash.extend(self)
    hash
  end
  
  def results_sorted(params)
    case params[:order_by]
    when VideoCollection::DISTANCE
      videos = results_by_distance(params[:location])
    when DURATION
      videos = results_by_duration
    when PUBLISHED
      videos = results_by_publication
    when RATING
      videos = results_by_rating
    when VIEWS
      videos = results_by_views
    else
      videos = results
    end
    videos
  end
  
  protected

  def key(key)
    self['feed'] && self['feed'][key]
  end

  def results
    results = [key("entry")].flatten.compact
    results.map do |result|
      alt_result = result.inject({}) do |hash, (k, v)|
        result[k.downcase] = v
        result
      end
      OpenStruct.new(alt_result)
    end
  end

  def results_by_distance(point)
    results.sort do |a,b|
      GeoPosition.distance_between(a, point) <=> GeoPosition.distance_between(b, point)
    end
  end

  def results_by_duration
    results.sort do |a,b|
      a.send(:'media:group')['yt:duration']['seconds'] <=> b.send(:'media:group')['yt:duration']['seconds']
    end
  end

  def results_by_publication
    results.sort do |a,b|
      # TODO: je toto spravne porovnanie 2 XSL dates?
      a.send(:'published') <=> b.send(:'published')
    end
  end
  
  def results_by_rating
    results.sort do |a,b|
      a.send(:'gd:rating')['average'] <=> b.send(:'gd:rating')['average']
    end
  end

  def results_by_views
    results.sort do |a,b|
      a.send(:'yt:statistics')['viewCount'] <=> b.send(:'yt:statistics')['viewCount']
    end
  end
end