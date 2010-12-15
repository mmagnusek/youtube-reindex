class VideosController < ApplicationController
  def index
    keyword = params[:q]
    if keyword
      @videos = VideoSearch.new({:q => keyword, :orderby => 'relevance' })
      # @videos.sort()
    else
      @videos = VideoSearch.get_top_favorites
    end
  end
  
  def show
  end
end
