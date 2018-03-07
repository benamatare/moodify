class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.integer :mood
      t.text :youtube_link
      t.timestamps
    end
  end
end
