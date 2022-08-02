class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  before_validation :fix_email

  def fix_email
    if email.present?
      self.email.strip!
      self.email.downcase!
    end
  end
  
end
