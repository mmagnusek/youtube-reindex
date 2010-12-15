# encoding: utf-8

require 'ostruct'

module VideoCollection

  def self.new(hash, params = {})
    hash.extend(self)
    hash
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
  
  def results_by_location(point)
    point = {:lat => "50.42689340423504", :lng => "16.195220947265625"}
    results.sort do |a,b|
      GeoPosition.distance_between(a,point) <=> GeoPosition.distance_between(b,point)
    end
  end

  protected

  def key(key)
    self['feed'] && self['feed'][key]
  end
  
end