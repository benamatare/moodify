class CreatePlaylists < ActiveRecord::Migration[5.1]
  def change
    create_table :playlists do |t|
      t.string :title
      t.integer :rating, default: 0
      t.integer :user_id
      t.integer :mood
      t.timestamps
    end
  end
end
