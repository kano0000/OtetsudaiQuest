class CreateChildRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :child_rewards do |t|
      t.references :child, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
