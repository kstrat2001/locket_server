class CreateLockets < ActiveRecord::Migration
  def change
    create_table :lockets do |t|
      t.string :title
      t.integer :open_image_id
      t.integer :closed_image_id
      t.integer :chain_image_id
      t.integer :mask_image_id

      t.timestamps null: false
    end
  end
end
