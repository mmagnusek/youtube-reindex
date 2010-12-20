# encoding: utf-8

class VideosController < ApplicationController
  require 'geokit'
  
  def index
    keyword = params[:q]
    location = params[:location]
    
    params = {:q => keyword }
    unless location.blank?
      geo_location = Geokit::Geocoders::GoogleGeocoder.geocode location.removeaccents
      params.merge!({:location => geo_location.ll})
      p geo_location
      @videos = VideoSearch.new(params).results_by_location(geo_location.ll)
    else
      @videos = VideoSearch.new(params).results
    end
  end
  
  def show
    @video = VideoSearch.get_video(params[:id])['entry']
  end
end

