class AddPresentedDateToChildRewards < ActiveRecord::Migration[6.1]
  def change
    add_column :child_rewards, :presented_date, :date
  end
end
