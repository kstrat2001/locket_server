require 'spec_helper'

describe ImageAsset do
  
  let(:image_asset) { FactoryGirl.build :image_asset }
  subject { image_asset }

  it { should respond_to(:title) }
  it { should respond_to(:anchor_x) }
  it { should respond_to(:anchor_y) }
end
