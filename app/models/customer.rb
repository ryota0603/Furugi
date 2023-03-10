class Customer < ApplicationRecord
  GUEST_EMAIL = "guest@example.com"
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :items
  has_many :favorites, dependent: :destroy 
  has_many :post_comments, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy 
  # フォローする機能
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
 # フォローされた機能
# 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 } 
  validates :introduction, length: {maximum: 50}
  validates :is_deleted, inclusion: { in: [true, false] }
  validates :email, uniqueness: true

  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # フォローしたときの処理
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  # フォローを外すときの処理
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  # フォローしているか判定する記述
  def following?(customer)
    followings.include?(customer)
  end
  
  #会員検索機能の記述
  def self.search_for(key_word, method)
    if method == 'name'
      Customer.where('name LIKE ?' ,'%' + key_word + '%')
    else 
      Customer.where('email LIKE ?' ,'%' + key_word + '%')
    end
  end
  #ゲストログインの記述
  def self.guest
    find_or_create_by!(email: GUEST_EMAIL) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestuser"
    end
  end
  
  def guest?
    email == GUEST_EMAIL
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
