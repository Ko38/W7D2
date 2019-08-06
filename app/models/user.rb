class User < ApplicationRecord
    validates :password_digest, presence: true
    validates :session_token, uniqueness: true

    after_initialize :ensure_session_token

    def generate_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password) 
        @password = password
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end 

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        return nil if user.nil?
        if user.is_password?(password)
            return user
        end
        nil
    end
end
