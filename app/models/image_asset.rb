class ImageAsset < ActiveRecord::Base

  # The image asset image stored by paperclip
  has_attached_file :image, styles: { thumb: "64x64>" }

  validates :title, :user_id, presence: true
  validates :anchor_x, :anchor_y, presence: true, numericality: { only_integer: true }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :user
end
