require 'spec_helper'

describe Api::V1::ImageAssetsController do
  describe "GET #show" do
    before(:each) do
      @image_asset = FactoryGirl.create :image_asset
      get :show, id: @image_asset.id
    end

    it "returns the information about a reporter on a hash" do
      image_asset_response = json_response[:image_asset]
      expect(image_asset_response[:title]).to eql @image_asset.title
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :image_asset }
      get :index
    end

    it "returns 4 records from the database" do
      assets_response = json_response
      expect(assets_response[:image_assets].size).to eq(4)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @image_asset_attributes = FactoryGirl.attributes_for :image_asset
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, image_asset: @image_asset_attributes }
      end

      it "renders the json representation for the image_asset record just created" do
        asset_response = json_response[:image_asset]
        expect(asset_response[:title]).to eql @image_asset_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_image_asset_attributes = { title: "My Chain", anchor_x: nil, anchor_y: "eight" }
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, image_asset: @invalid_image_asset_attributes }
      end

      it "renders errors in json" do
        asset_response = json_response
        expect(asset_response).to have_key(:errors)
      end

      it "renders the json errors when the image asset could not be created" do
        asset_response = json_response
        expect(asset_response[:errors][:anchor_x]).to include "is not a number"
        expect(asset_response[:errors][:anchor_y]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @image_asset = FactoryGirl.create :image_asset, user: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @image_asset.id,
              image_asset: { title: "Red Heart" } }
      end

      it "renders the json representation for the updated user" do
        image_asset_response = json_response[:image_asset]
        expect(image_asset_response[:title]).to eql "Red Heart"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, { user_id: @user.id, id: @image_asset.id,
              image_asset: { anchor_x: "bad data" } }
      end

      it "renders an errors json" do
        image_asset_response = json_response
        expect(image_asset_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        image_asset_response = json_response
        expect(image_asset_response[:errors][:anchor_x]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @image_asset = FactoryGirl.create :image_asset, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, { user_id: @user.id, id: @image_asset.id }
    end

    it { should respond_with 204 }
  end

end
