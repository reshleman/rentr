class Order
  def initialize(reservation, card)
    @reservation = reservation
    @card = card
  end

  def pay
    Stripe::Charge.create(
      customer: stripe_customer.id,
      amount: @reservation.price_in_cents,
      description: @reservation.listing_title,
      currency: "usd"
    )
  end

  private

  def stripe_customer
    Stripe::Customer.create(
      email: @reservation.user_email,
      card:  @card
    )
  end

  # Move to Reservation
  def price_in_cents(dollars)
    dollars * 100
  end

  # Make user_email and listing_title methods on Reservation
end
