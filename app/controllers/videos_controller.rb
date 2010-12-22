# encoding: utf-8

class VideosController < ApplicationController
  require 'geokit'
  
  def index
    keyword = params[:q]
    location = params[:location]

    if location.blank?
      location = Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip).city
    end

    logger.info "Location Keyword: " + location + " IP: " + request.remote_ip

    geo_location = Geokit::Geocoders::GoogleGeocoder.geocode location.removeaccents
    params = {:q => keyword, :location => geo_location.ll}
    logger.info geo_location
    p geo_location
    @videos = VideoSearch.new(params).results_by_location(geo_location.ll)
  end
  
  def show
    @video = VideoSearch.get_video(params[:id])['entry']
  end
end

