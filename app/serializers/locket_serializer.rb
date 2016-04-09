class LocketSerializer < ActiveModel::Serializer
  attributes :id, :title, :updated_at

  has_one :open_image
  has_one :closed_image
  has_one :chain_image
  has_one :mask_image
end
