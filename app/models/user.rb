class User < ApplicationRecord
  has_many :playlists
  has_many :playlist_songs, through: :playlists

  validates :username, :first_name, :last_name, :email , :password, :password_confirmation, presence: true
  validates :username, uniqueness: true
    validates :email , format: { with: /\A\S+@.+\.\S+\z/ } #Email must conform to email standards
    validates :username, format: { with: /[a-zA-Z0-9]{0,15}/ } #Username must have no special characers and be at most 15 characters long
    validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*[0-9]).{7,}/ } #Password must have at least 1 number, 1 special character and be at least 7 characters long
  has_secure_password


  def authenticate(password)
    salt = password_digest[0..28]
    hashed = BCrypt::Engine::hash_secret(password, salt)
      if hashed == self.password_digest
        true
      else
        nil
      end
  end


end
