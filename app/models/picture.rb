class Picture < ApplicationRecord
  belongs_to :user
  mount_uploader :name, AvatarUploader
  serialize :name, JSON
  has_many :comments
end
