class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :listing, index: true

      t.timestamps
    end
  end
end
