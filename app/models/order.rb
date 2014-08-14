class Order < ActiveRecord::Base
  belongs_to :reservation

  validates :reservation, presence: true
  validates :stripe_charge, presence: true
  validates :amount_paid, presence: true, numericality: { greater_than: 0 }

  def pay(card)
    create_or_update_stripe_customer(card)
    self.stripe_charge = stripe_charge.id
    self.amount_paid = reservation.total_price
    save!
  end

  private

  def stripe_charge
    Stripe::Charge.create(
      customer: @stripe_customer.id,
      amount: reservation.price_in_cents,
      description: reservation.listing_title,
      currency: "usd"
    )
  end

  def create_or_update_stripe_customer(card)
    if reservation.guest_stripe_customer
      update_stripe_customer(card)
    else
      create_stripe_customer(card)
    end
  end

  def update_stripe_customer(card)
    @stripe_customer = Stripe::Customer.
      retrieve(reservation.guest_stripe_customer)
    @stripe_customer.card = card
    @stripe_customer.save
  end

  def create_stripe_customer(card)
    @stripe_customer = Stripe::Customer.create(
      email: reservation.guest_email,
      card: card
    )
    reservation.user.update(stripe_customer: @stripe_customer.id)
  end
end
