class SearchResultsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @query = params[:query]
    @price = params[:price]
    @listings = Listing.search(@query, @price)
  end
end
