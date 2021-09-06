class User < ApplicationRecord
    before_save :email_downcase

    attribute :admin, :boolean, default: false

    has_secure_password

    has_one :section, dependent: :destroy
  
    validates :name,presence: true
    validates :email,presence: true, uniqueness: true
    validates :password,presence: true,length: {minimum: 6}

    def email_downcase
        self.email=self.email.downcase
    end

end