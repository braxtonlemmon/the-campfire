class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :inviter_id
      t.integer :invitee_id

      t.timestamps
		end
		add_index :friend_requests, :inviter_id
		add_index :friend_requests, :invitee_id
		add_index :friend_requests, [:inviter_id, :invitee_id], unique: true
  end
end
