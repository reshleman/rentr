class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :reservation, index: true, null: false
      t.string :stripe_charge_id, null: false

      t.timestamps
    end
  end
end
