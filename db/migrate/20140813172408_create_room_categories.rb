class CreateRoomCategories < ActiveRecord::Migration
  def change
    create_table :room_categories do |t|
      t.string :name, null: false

      t.timestamps
    end

    change_table :listings do |t|
      t.references :room_category
    end
  end
end
