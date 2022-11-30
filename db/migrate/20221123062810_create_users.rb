class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :spotify_uid
      t.string :genre
      t.float :energy
      t.float :positive

      t.timestamps
    end
  end
end
