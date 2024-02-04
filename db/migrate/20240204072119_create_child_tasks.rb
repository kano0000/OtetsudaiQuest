class CreateChildTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :child_tasks do |t|
      t.references :child, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.timestamps
    end
  end
end
