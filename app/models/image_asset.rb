class ImageAsset < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates :anchor_x, :anchor_y, presence: true, numericality: { only_integer: true }
  
  belongs_to :user
end
