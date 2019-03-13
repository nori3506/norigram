class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :picture
  default_scope -> { order(created_at: :asc) }
end
