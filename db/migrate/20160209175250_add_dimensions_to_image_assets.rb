class AddDimensionsToImageAssets < ActiveRecord::Migration
  def change
    add_column :image_assets, :width, :integer, null: false, default: 0
    add_column :image_assets, :height, :integer, null: false, default: 0

    image_assets = ImageAsset.all

    image_assets.each do | asset |
      dims = Paperclip::Geometry.from_file(asset.image.url)
      asset.width = dims.width.to_i
      asset.height = dims.height.to_i
      asset.save
    end
  end
end
