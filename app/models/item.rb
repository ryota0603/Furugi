class Item < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  has_one_attached :image
  
  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  validates :name,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :image, presence: true
  validates :shopname, presence: true
  validates :address, presence: true
  
  
  geocoded_by :address
  after_validation :geocode
  
  # イイね機能の記述
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  # 検索機能の記述　条件分岐、大元はコントローラーに記述
  def self.search_for(content, method)
    if method == 'perfect'
      Item.where(name: content)
    elsif method == 'forward'
      Item.where('name LIKE ?', content+'%')
    elsif method == 'backward'
      Item.where('name LIKE ?', '%'+content)
    else
      Item.where('name LIKE ?', '%'+content+'%')
    end
  end
end
