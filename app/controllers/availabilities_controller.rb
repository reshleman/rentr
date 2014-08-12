class AvailabilitiesController < ApplicationController
  def new
    @listing = find_listing
    @available_date = AvailableDate.new
  end

  def create
    listing = find_listing

    if listing.make_available_on(available_date_params)
      redirect_to listing
    else
      redirect_to listing, alert: "Invalid date."
    end
  end

  private

  def available_date_params
    params.require(:available_date).permit(:date)
  end

  def find_listing
    Listing.find(params[:listing_id])
  end
end
