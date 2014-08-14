class ChargesController < ApplicationController
  def new
  end

  def create
    reservation = find_reservation
    card = find_card

    Order.new(reservation, card).pay

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

  private

  def find_reservation
    Reservation.find(params[:id])
  end

  def find_card
    params[:stripeToken]
  end
end
