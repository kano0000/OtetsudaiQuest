class AddDefaultToChildPoint < ActiveRecord::Migration[6.1]
  def change
    change_column_default :children, :point, 0
  end
end
