class MakeDateRangesIntoDates < ActiveRecord::Migration
  class AvailableDateRange < ActiveRecord::Base
  end

  class AvailableDate < ActiveRecord::Base
    validates :date, uniqueness: { scope: :listing_id }
  end

  def change
    create_table :available_dates do |t|
      t.belongs_to :listing, index: true, null: false
      t.date :date, null: false

      t.timestamps
    end

    AvailableDateRange.all.each do |range|
      (range.start_date..range.end_date).each do |date|
        AvailableDate.create(date: date, listing_id: range.listing_id)
      end
    end

    drop_table :available_date_ranges
  end
end
