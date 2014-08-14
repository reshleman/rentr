class ChargesController < ApplicationController
  def new
  end

  def create
    reservation = Reservation.find(params[:id])
    card = params[:stripeToken]

    Transaction.new(reservation, card).pay!

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
