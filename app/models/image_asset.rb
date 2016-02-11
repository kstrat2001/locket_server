class ImageAsset < ActiveRecord::Base

  # The image asset image stored by paperclip
  has_attached_file :image, styles: { thumb: "64x64>" }
  before_save :save_dimensions

  validates :title, :user_id, presence: true
  validates :anchor_x, :anchor_y, presence: true, numericality: { only_integer: true }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  belongs_to :user

  def save_dimensions
    tempfile = image.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.width = geometry.width.to_i
      self.height = geometry.height.to_i
    end
  end
end
