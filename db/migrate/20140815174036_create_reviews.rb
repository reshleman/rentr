class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :reservation, index: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
