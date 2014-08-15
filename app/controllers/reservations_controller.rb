class ReservationsController < ApplicationController
  helper DateHelpers

  def new
    @listing = find_listing
    @reservation = Reservation.new
  end

  def create
    @listing = find_listing

    if valid_dates?
      @reservation = @listing.reserve(
        current_user,
        DateRange.new(start_date, end_date)
      )
    end

    if @reservation && @reservation.valid?
      redirect_to @reservation
    else
      flash[:alert] = "Invalid Reservation Dates"
      @reservation = Reservation.new
      render :new
    end
  end

  def show
    @reservation = find_reservation

    if current_user.id != @reservation.user_id
      redirect_to @reservation.listing
    end
  end

  def index
    @reservations = current_user.reservations
  end

  private

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
