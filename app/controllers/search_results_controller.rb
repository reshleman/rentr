class SearchResultsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @city = params[:city]
    @price = params[:price]
    @property_categories = PropertyCategory.all
    @room_categories = RoomCategory.all
    @listings = Listing.search(params)
  end
end
