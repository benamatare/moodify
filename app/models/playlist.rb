class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs
  validates :title, presence: true 

end
