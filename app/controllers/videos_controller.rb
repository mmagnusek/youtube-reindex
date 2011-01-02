# encoding: utf-8

class VideosController < ApplicationController
  require 'geokit'
  
  def index
    order = params[:o].to_i
    keyword = params[:q]
    location = params[:location]

    if location.blank?
      location = Geokit::Geocoders::IpGeocoder.geocode(request.remote_ip).city
    end

    geo_location = Geokit::Geocoders::GoogleGeocoder.geocode location.removeaccents
    params = {:q => keyword, :location => geo_location.ll, :order_by => order}

    @order_by_options = {
      'Distance' => VideoCollection::DISTANCE,
      'Duration' => VideoCollection::DURATION,
      'Published (Date)' => VideoCollection::PUBLISHED,
      'Rating' => VideoCollection::RATING,
      'Views' => VideoCollection::VIEWS}
    @videos = VideoSearch.new(params).results_sorted(params)
  end
  
  def show
    @video = VideoSearch.get_video(params[:id])['entry']
  end
end

