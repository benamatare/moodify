class CreateMoods < ActiveRecord::Migration[5.1]
  def change
    create_table :moods do |t|
      t.integer :mood_rating
      t.integer :playlist_song_id
      t.timestamps
    end
  end
end
