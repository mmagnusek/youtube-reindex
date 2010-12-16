class GeoPosition

  KMS_PER_MILE = 1.609
  EARTH_RADIUS_IN_MILES = 3963.19
  EARTH_RADIUS_IN_KMS = EARTH_RADIUS_IN_MILES * KMS_PER_MILE

  class << self
    def distance_between(from, to)
      from  = self.ll from
      to    = {:lat => to.split(',').first, :lng => to.split(',').last}
      return 23423423 unless from
      begin
        EARTH_RADIUS_IN_KMS * 
            Math.acos( Math.sin(deg2rad(from[:lat])) * Math.sin(deg2rad(to[:lat])) + 
            Math.cos(deg2rad(from[:lat])) * Math.cos(deg2rad(to[:lat])) * 
            Math.cos(deg2rad(to[:lng]) - deg2rad(from[:lng])))
      rescue Errno::EDOM
        0.0
      end
    end
  
    def ll(video)
      if video.send(:'georss:where') && video.send(:'georss:where')['gml:Point'] && video.send(:'georss:where')['gml:Point']['gml:pos']
        pos = video.send(:'georss:where')['gml:Point']['gml:pos'].split();
        {:lat => pos.first, :lng => pos.last}
      else
        nil
      end
    end
  
    def deg2rad(degrees)
      degrees.to_f / 180.0 * Math::PI
    end
  
  end
end