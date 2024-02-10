class AddLevelToChild < ActiveRecord::Migration[6.1]
  def change
    add_column :children, :level, :integer, default: 0
  end
end
