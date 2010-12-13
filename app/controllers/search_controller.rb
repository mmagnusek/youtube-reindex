class SearchController < ApplicationController
  def index
    @videos = YoutubeSearch.get_top_favorites
  end
end
