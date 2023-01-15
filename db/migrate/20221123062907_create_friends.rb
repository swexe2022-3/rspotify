class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.string :f_spotify_uid
      t.timestamps
    end
  end
end
