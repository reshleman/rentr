class AvailableDateRangesController < ApplicationController
  def new
    @listing = find_listing
    @available_date_range = AvailableDateRange.new
  end

  def create
    available_date_range = AvailableDateRange.new(available_date_range_params)
    available_date_range.listing = find_listing
    available_date_range.save
    redirect_to available_date_range.listing
  end

  private

  def available_date_range_params
    params.require(:available_date_range).permit(:start_date, :end_date)
  end

  def find_listing
    Listing.find(params[:listing_id])
  end
end
