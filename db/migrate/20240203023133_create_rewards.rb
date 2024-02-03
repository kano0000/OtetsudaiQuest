class CreateRewards < ActiveRecord::Migration[6.1]
  def change
    create_table :rewards do |t|
      t.string :name
      t.text :description
      t.integer :point
      t.boolean :published, default: true
      t.timestamps
    end
  end
end
