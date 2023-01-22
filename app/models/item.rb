class Item < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  has_one_attached :image
  
  has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  validates :name,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :image, presence: true
  validates :shopname, presence: true
  validates :address, presence: true
  
  
  geocoded_by :address
  after_validation :geocode
  
  
  def save_tags(saveitem_tags)
    # 現在のユーザーの持っているskillを引っ張ってきている
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 今bookが持っているタグと今回保存されたものの差をすでにあるタグとする。古いタグは消す。
    old_tags = current_tags - saveitem_tags
    # 今回保存されたものと現在の差を新しいタグとする。新しいタグは保存
    new_tags = saveitem_tags - current_tags
		
    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
		
    # Create new taggings:
    new_tags.each do |new_name|
      item_tag = Tag.find_or_create_by(name:new_name)
      # 配列に保存
      self.tags << item_tag
    end
  end
  
  # イイね機能の記述
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  # 検索機能の記述　条件分岐、大元はコントローラーに記述
  def self.search_for(content,method)
    if method == 'area'
      Item.where("address LIKE ?",'%'+content+'%')
    elsif method == 'key_word'
      Item.where('name LIKE ? or shopname LIKE ?','%'+content+'%','%'+content+'%')
    end
  end
end
