class OrdersController < ApplicationController
  def create
    @reservation = find_reservation
    card = find_card

    Order.new(reservation: @reservation).pay(card)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to @reservation
  end

  private

  def find_reservation
    Reservation.find(params[:reservation_id])
  end

  def find_card
    params[:stripeToken]
  end
end
