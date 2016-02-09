class LocketSerializer < ActiveModel::Serializer
  attributes :id, :title, :open_img, :closed_image, :chain_image, :mask_image

  def open_img
    object.open_image.image.url
  end
end
