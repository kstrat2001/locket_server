class Locket < ActiveRecord::Base
  belongs_to :user

  validates :title, :user_id, presence: true
end
