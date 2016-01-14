class CreateImageAssets < ActiveRecord::Migration
  def change
    create_table :image_assets do |t|
      t.string :title, default: ""
      t.integer :anchor_x, default: 0
      t.integer :anchor_y, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
