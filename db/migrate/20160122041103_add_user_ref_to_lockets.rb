class AddUserRefToLockets < ActiveRecord::Migration
  def change
    add_reference :lockets, :user, index: true, foreign_key: true
  end
end
