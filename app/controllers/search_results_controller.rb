class SearchResultsController < ApplicationController
  skip_before_action :require_login, only: [:show]

  def show
    @city = params[:city]
    @price = params[:price]
    @accommodates = params[:accomodates]
    @property_categories = PropertyCategory.all
    @room_categories = RoomCategory.all
    @listings = Listing.search(params)
    @search_query = search_query
  end

  private

  def search_query
    [
      params[:city],
      params[:price],
      params[:property_categories],
      params[:room_categories]
    ].select(&:present?).join(" ")
  end
end
