class RenamePropertyTypesToPropertyCategories < ActiveRecord::Migration
  def change
    rename_table :property_types, :property_categories
    rename_column :listings, :property_type_id, :property_category_id
  end
end
