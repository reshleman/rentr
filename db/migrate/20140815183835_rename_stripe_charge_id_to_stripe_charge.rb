class RenameStripeChargeIdToStripeCharge < ActiveRecord::Migration
  def change
    rename_column :orders, :stripe_charge_id, :stripe_charge
  end
end
