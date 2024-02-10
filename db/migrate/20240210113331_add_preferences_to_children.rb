class AddPreferencesToChildren < ActiveRecord::Migration[6.1]
  def change
    add_column :children, :favorite_food, :string
    add_column :children, :future_dream, :string
  end
end
