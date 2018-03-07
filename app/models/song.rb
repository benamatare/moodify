class Song < ApplicationRecord
  has_many :playlist_songs
  has_many :moods, through: :playlist_songs
end
