class CreateAvailableDateRanges < ActiveRecord::Migration
  def change
    create_table :available_date_ranges do |t|
      t.belongs_to :listing, index: true, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
