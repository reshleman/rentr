class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :city
      t.string :address
      t.integer :price
      t.string :title
      t.text :description
      t.references :user

      t.timestamps
    end
  end
end
