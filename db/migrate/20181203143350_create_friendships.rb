class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user_a, null: false, foreign_key: { to_table: :users }
      t.references :user_b, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
