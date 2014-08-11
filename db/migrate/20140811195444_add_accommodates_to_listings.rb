class AddAccommodatesToListings < ActiveRecord::Migration
  def change
    add_column :listings, :accommodates, :integer, default: 1
  end
end
