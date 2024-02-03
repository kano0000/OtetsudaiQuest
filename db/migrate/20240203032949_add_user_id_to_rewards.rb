class AddUserIdToRewards < ActiveRecord::Migration[6.1]
  def change
    add_reference :rewards, :user, null: false, foreign_key: true
  end
end
