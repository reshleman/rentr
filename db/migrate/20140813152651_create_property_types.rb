class CreatePropertyTypes < ActiveRecord::Migration
  def change
    create_table :property_types do |t|
      t.string :name, null: false

      t.timestamps
    end

    change_table :listings do |t|
      t.references :property_type
    end
  end
end
