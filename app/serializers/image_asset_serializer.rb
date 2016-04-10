class ImageAssetSerializer < ActiveModel::Serializer
  attributes :id, :title, :updated_at, :anchor_x, :anchor_y, :width, :height, :image_full, :image_thumb

  def image_full
    object.image.url
  end

  def image_thumb
    object.image.url(:thumb)
  end

end
