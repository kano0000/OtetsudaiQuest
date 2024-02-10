class AddPublishedToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :published, :boolean, default: true
  end
end
