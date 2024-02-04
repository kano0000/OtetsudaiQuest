class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :point
      t.integer :num_people
      t.datetime :start_at
      t.datetime :end_at
      t.integer :status, default: 0
      t.references :user, foreign_key: true
      t.references :task_list, foreign_key: true

      t.timestamps
    end
  end
end
