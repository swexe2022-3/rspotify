class CreateMusicRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :music_requests do |t|
      t.string :f_user_id
      t.string :music_title
      t.integer :user_id
      t.timestamps
    end
  end
end
