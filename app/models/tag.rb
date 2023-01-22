class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :items, through: :post_tags
  scope :merge_items, -> (tags){ }
  
  def self.search_for(content)
    
      tags = Tag.where(name: content)
   
    
    return tags.inject(init = []) {|result, tag| result + tag.items}
    
  end
end
