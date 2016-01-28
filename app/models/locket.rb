class Locket < ActiveRecord::Base
  validates :title, :user_id, :open_image_id, :closed_image_id, :mask_image_id, :chain_image_id, presence: true

  belongs_to :user

  def open_image
    return ImageAsset.find(open_image_id)
  end

  def closed_image
    return ImageAsset.find(closed_image_id)
  end

  def mask_image
    return ImageAsset.find(mask_image_id)
  end

  def chain_image
    return ImageAsset.find(chain_image_id)
  end
end
