class VideosController < ApplicationController
  def index
    keyword = params[:q]
    if keyword
      @videos = Video.get_by_keyword(keyword)
    else
      @videos = Video.get_top_favorites
    end
  end
  
  def show
  end
end
