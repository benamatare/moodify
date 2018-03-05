class User < ApplicationRecord
  has_many :playlists
  has_many :songs, through: :playlists
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
