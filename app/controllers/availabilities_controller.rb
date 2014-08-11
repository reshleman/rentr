class AvailabilitiesController < ApplicationController
  def new
    @listing = find_listing
    @available_date_range = AvailableDateRange.new
  end

  def create
    listing = find_listing

    if listing.make_available_during(available_date_range_params)
      redirect_to listing
    else
      redirect_to listing, alert: "Invalid date range."
    end
  end

  private

  def available_date_range_params
    params.require(:available_date_range).permit(:start_date, :end_date)
  end

  def find_listing
    Listing.find(params[:listing_id])
  end
end
