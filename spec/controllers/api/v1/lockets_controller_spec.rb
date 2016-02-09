require 'spec_helper'

RSpec.describe Api::V1::LocketsController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      @image = FactoryGirl.create :image_asset, user: @user
      @locket = FactoryGirl.create :locket, user: @user, open_image_id: @image.id, closed_image_id: @image.id, chain_image_id: @image.id, mask_image_id: @image.id

      get :show, id: @locket.id
    end

    it "Returns the locket info in json format" do
      locket_response = json_response[:locket]
      expect(locket_response[:title]).to eql @locket.title
      expect(locket_response[:open_image][:id]).to eql @image.id
      expect(locket_response[:closed_image][:id]).to eql @image.id
      expect(locket_response[:chain_image][:id]).to eql @image.id
      expect(locket_response[:mask_image][:id]).to eql @image.id
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { 
        user = FactoryGirl.create :user
        image = FactoryGirl.create :image_asset, user: user
        locket = FactoryGirl.create :locket, user: user, open_image_id: image.id, closed_image_id: image.id, chain_image_id: image.id, mask_image_id: image.id
      }

      get :index
    end

    it "returns 4 records from the database" do
      lockets_response = json_response
      expect(lockets_response[:lockets].size).to eq(4)
    end

    it { should respond_with 200 }
  end

end
