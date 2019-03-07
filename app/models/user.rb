class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length:{maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :username, presence:true, length: {maximum: 40},uniqueness: {case_sensitive: false}
  validates :password, presence:true, length:{minimum: 6}, allow_nil: true
  has_secure_password
  has_many :pictures
  mount_uploader :image, AvatarUploader
  serialize :image, JSON
  has_many :comments
end
