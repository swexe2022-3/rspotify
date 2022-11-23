class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.string :uid
      t.string :friend_uid

      t.timestamps
    end
  end
end
