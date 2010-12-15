class VideosController < ApplicationController
  def index
    keyword = params[:q]
    if keyword
      @videos = YoutubeSearch.get_by_keyword(keyword)
    else
      @videos = YoutubeSearch.get_top_favorites
    end
  end
  
  def show
  end
end
