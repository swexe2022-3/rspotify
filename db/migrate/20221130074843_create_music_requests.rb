class CreateMusicRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :music_requests do |t|
      t.string :uid
      t.string :request_friend_id
      t.string :music_id
      t.timestamps
    end
  end
end
