class User < ApplicationRecord
  before_save{self.email = email.downcase}
  validates :name, precense: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[W+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, precense: true, length: {maximim: 255},
      format: {with: VALID_EMAIL_REGEX},
      uniqueness: {case_sensitive: false}
  has_secure_password
  validates :passwrod, precense: true, length: {minimun: 6}
end
