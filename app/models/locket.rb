class Locket < ActiveRecord::Base
    include Workflow
    workflow do
      state :new do
          event :submit, :transitions_to => :waiting_for_review
      end
      state :waiting_for_review do
          event :review, :transitions_to => :in_review
      end
      state :in_review do
          event :accept, :transitions_to => :accepted
          event :reject, :transitions_to => :rejected
      end
      state :accepted
      state :rejected do
          event :resubmit, :transitions_to => :waiting_for_review
      end
    end

  validates :title, :user_id, :open_image_id, :closed_image_id, :mask_image_id, :chain_image_id, presence: true

  belongs_to :user

  def open_image
    return ImageAsset.find(open_image_id)
  end

  def closed_image
    return ImageAsset.find(closed_image_id)
  end

  def mask_image
    return ImageAsset.find(mask_image_id)
  end

  def chain_image
    return ImageAsset.find(chain_image_id)
  end
end
