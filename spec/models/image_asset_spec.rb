require 'spec_helper'

describe ImageAsset do
  
  let(:image_asset) { FactoryGirl.build :image_asset }
  subject { image_asset }

  it { should respond_to(:title) }
  it { should respond_to(:anchor_x) }
  it { should respond_to(:anchor_y) }
  it { should respond_to(:user_id) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :anchor_x }
  it { should validate_presence_of :anchor_y }
  it { should validate_presence_of :user_id }

end
