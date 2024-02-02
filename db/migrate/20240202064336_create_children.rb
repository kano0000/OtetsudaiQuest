class CreateChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :children do |t|
      t.string :name
      t.date :birth_at
      t.text :introduction
      t.integer :point
      
      t.timestamps
    end
  end
end
