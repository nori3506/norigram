class Picture < ApplicationRecord
  belongs_to :user
  has_many :comments
  mount_uploader :name, AvatarUploader
  serialize :name, JSON
  default_scope -> { order(created_at: :desc) }
end
