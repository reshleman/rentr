class ReservationsController < ApplicationController
  helper DateHelpers

  def new
    @listing = find_listing
    @reservation = Reservation.new
  end

  def create
    listing = find_listing
    reservation = handle_create(listing)
    handle_redirect(listing, reservation)
  end

  def show
    @reservation = find_reservation
  end

  def index
    @reservations = current_user.reservations
  end

  private

  def handle_create(listing)
    if valid_dates?
      date_range = DateRange.new(start_date, end_date)
      listing.reserve(current_user, date_range)
    end
  end

  def handle_redirect(listing, reservation)
    if reservation && reservation.id
      redirect_to [listing, reservation]
    else
      handle_create_error(listing)
    end
  end

  def handle_create_error(listing)
    flash[:alert] = "Invalid Reservation Dates"
    redirect_to listing
  end

  def start_date
    reservation_params[:start_date].to_date
  end

  def end_date
    reservation_params[:end_date].to_date
  end

  def valid_dates?
    start_date.present? && end_date.present?
  end

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
