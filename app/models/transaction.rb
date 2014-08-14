class Transaction
  def initialize(reservation, card)
    @reservation = reservation
    @card = card
  end

  def pay!
    # Amount in cents
    @amount = price_in_cents(@reservation.price)

    stripe_customer = Stripe::Customer.create(
      :email => @reservation.user.email,
      :card  => @card
    )

    Stripe::Charge.create(
      :customer    => stripe_customer.id,
      :amount      => @amount,
      :description => @reservation.listing.title,
      :currency    => 'usd'
    )
  end

  private

  def price_in_cents(dollars)
    dollars * 100
  end
end
