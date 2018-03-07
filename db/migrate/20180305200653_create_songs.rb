class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.integer :mood
      t.string :video_id
      t.timestamps
    end
  end
end
