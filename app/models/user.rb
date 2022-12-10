class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books , dependent: :destroy
  has_many :favorites ,dependent: :destroy
  has_many :book_comments ,dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def following?(user)
    followings.include?(user)
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def self.looks(search,word)
    if search == "完全一致"
      User.where("name LIKE?", "#{word}")
    elsif search == "前方一致"
      User.where("name LIKE?", "#{word}%")
    elsif search == "後方一致"
      User.where("name LIKE?", "%#{word}")
    elsif search == "部分一致"
      User.where("name LIKE?", "%#{word}%")
    else
      User.all
    end
  end

end
