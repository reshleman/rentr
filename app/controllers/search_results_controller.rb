class SearchResultsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @city = params[:city]
    @price = params[:price]
    @accommodates = params[:accomodates]
    @property_categories = PropertyCategory.all
    @listings = Listing.search(params)
  end
end
