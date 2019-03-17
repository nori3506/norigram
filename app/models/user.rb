class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length:{maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :username, presence:true, length: {maximum: 40},uniqueness: {case_sensitive: false}
  validates :password, presence:true, length:{minimum: 6}, allow_nil: true
  has_secure_password
  has_many :comments, dependent: :destroy
  has_many :pictures, dependent: :destroy
  mount_uploader :image, AvatarUploader
  serialize :image, JSON
  
  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  validates :term, :inclusion => {:in => [true, false]}

  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Picture.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
end
