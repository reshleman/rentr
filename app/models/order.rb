class Order < ActiveRecord::Base
  belongs_to :reservation

  validates reservation, presence: true
  validates stripe_charge_id, presence: true

  def pay(card)
    find_or_create_stripe_customer
    add_card(card)
    create(stripe_charge_id: stripe_charge(card).id)
  end

  private

  def stripe_charge(card)
    Stripe::Charge.create(
      customer: @stripe_customer.id,
      card: card,
      amount: @reservation.price_in_cents,
      description: @reservation.listing_title,
      currency: "usd"
    )
  end

  def find_or_create_stripe_customer
    if @reservation.guest_stripe_id
      @stripe_customer = Stripe::Customer.retrieve(@reservation.guest_stripe_id)
    else
      @stripe_customer = Stripe::Customer.create(email: @reservation.user_email)
      @reservation.user.update(stripe_customer_id: @stripe_customer.id)
    end
  end

  def add_card(card)
    @stripe_customer.cards.create(card: card)
  end

  # Move to Reservation
  def price_in_cents(dollars)
    dollars * 100
  end

  # Make user_email, listing_title, guest_stripe_id methods on Reservation
end
