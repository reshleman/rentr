class RenameStripeCustomerIdToStripeCustomer < ActiveRecord::Migration
  def change
    rename_column :users, :stripe_customer_id, :stripe_customer
  end
end
