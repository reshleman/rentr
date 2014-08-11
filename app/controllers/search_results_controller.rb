class SearchResultsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @query = params[:query]
    @listings = Listing.search(@query)
  end
end
