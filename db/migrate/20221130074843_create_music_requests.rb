class CreateMusicRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :music_requests do |t|
      t.string :user_spotify_id
      t.string :friend_spotify_id
      t.string :music_title
      t.timestamps
    end
  end
end
