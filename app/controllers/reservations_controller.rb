class ReservationsController < ApplicationController
  helper DateHelpers

  def new
    @listing = find_listing
    @reservation = Reservation.new
  end

  def create
    @listing = find_listing
    dates = DateParser.new(reservation_params)
    date_range = DateRange.new(dates)

    if dates.valid?
      @reservation = @listing.reserve(
        current_user,
        date_range
      )
    end


    if dates.valid? && @reservation.id
      redirect_to [@listing, @reservation]
    else
      flash[:alert] = "Invalid Reservation Dates"
      redirect_to @listing
    end
  end

  def show
    @reservation = find_reservation
  end

  def index
    @reservations = current_user.reservations
  end

  private

  def find_reservation
    Reservation.find(params[:id])
  end

  def find_listing
    Listing.find(params[:listing_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
