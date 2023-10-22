class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books, dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_one_attached :profile_image
  
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followee_id'
  has_many :followers,through: :reverse_of_relationships ,source: :follower
  
  # フォローしている人
  has_many :relationships, class_name: "Relationship",foreign_key: "follower_id"
  has_many :followings, through: :relationships ,source: :followee
  
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  
  
  def follow(another_user)
    unless self == another_user
      self.relationships.find_or_create_by(followee_id: another_user.id)
    end
  end
  
  def unfollow(another_user)
    unless self == another_user
      relationship = self.relationships.find_by(followee_id: another_user.id)
      relationship.destroy if relationship
    end
  end
  
  def following?(user)
    relationships.find_by(followee_id: user.id).present?
  end
  
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
    
end
