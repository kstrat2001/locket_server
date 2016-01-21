class AddImageToImageAssets < ActiveRecord::Migration

  def self.up
    add_attachment :image_assets, :image
  end

  def self.down
    remove_attachment :image_assets, :image
  end
end
