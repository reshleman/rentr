class SearchResultsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @city = params[:city]
    @price = params[:price]
    @listings = Listing.search(params)
  end
end
