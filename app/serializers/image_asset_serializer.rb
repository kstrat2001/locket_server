class ImageAssetSerializer < ActiveModel::Serializer
  attributes :id, :title, :anchor_x, :anchor_y, :image_full, :image_thumb

  def image_full
    object.image.url
  end

  def image_thumb
    object.image.url(:thumb)
  end

end
