class RemoveDescriptionToProduct < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :description
  end
end
