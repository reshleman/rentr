class AddAmountPaidToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :amount_paid, :integer, null: false
  end
end
