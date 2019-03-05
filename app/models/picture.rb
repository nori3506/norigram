class Picture < ApplicationRecord
  belongs_to :user
  mount_uploader :name, AvatarUploader
  serialize :name, JSON
end
