class User < ApplicationRecord
  validates :name, presence: true, lenght: {maximum: Settings.max_length_user}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, lenght: {maximum: Settings.max_length_email},
              format: {with: VALID_EMAIL_REGEX},
              uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, lenght: {minimun: Settings.min_length_password}

  private

  def email_downcase
    self.email.downcase!
  end
end
