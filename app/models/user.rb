class User < ApplicationRecord
    before_save :email_downcase

    attribute :admin, :boolean, default: false

    has_secure_password

    has_one :section, dependent: :destroy

    has_many :admin_notifications,dependent: :destroy
  
    validates :name,presence: true
    validates :email,presence: true, uniqueness: true
    validates :password,presence: true,length: {minimum: 6},allow_nil: true

    def email_downcase
        self.email=self.email.downcase
    end

    def self.from_omniauth(auth)
      if User.find_by(email: auth.info.email)
        where(email: auth.info.email).first_or_initialize do |user|
          user.name = auth.info.name
          user.email = auth.info.email
          user.password_digest = digest(new_token)
        end
      end
    end

end