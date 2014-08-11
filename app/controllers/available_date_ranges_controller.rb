class AvailableDateRangesController < ApplicationController
  def new
    @listing = find_listing
    @available_date_range = AvailableDateRange.new
  end

  def create
    listing = find_listing
    if listing.add_available_date_range(available_date_range_params)
      redirect_to listing
    else
      render :new
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
