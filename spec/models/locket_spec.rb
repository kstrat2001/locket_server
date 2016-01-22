require 'spec_helper'

describe Locket do
  let(:locket) { FactoryGirl.build :locket }
  subject { locket }

  it { should respond_to(:title) }
  it { should respond_to(:open_image_id) }
  it { should respond_to(:closed_image_id) }
  it { should respond_to(:mask_image_id) }
  it { should respond_to(:chain_image_id) }
  it { should respond_to(:user_id) }

  it { should validate_presence_of :user_id }
  it { should validate_presence_of :title }
end
