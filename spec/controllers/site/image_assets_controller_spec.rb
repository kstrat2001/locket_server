require 'spec_helper'

describe Site::ImageAssetsController do

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      @image_asset = FactoryGirl.create :image_asset, user: @user
      @user.confirm
      sign_in(@user)

      view_response_format

      get :show, { user_id: @user.id, id: @image_asset.id }
    end

    it "renders the data for an image asset record" do
      response.should render_template('image_assets/show')
    end
  end

  describe "GET #new" do
    before(:each) do
      @user = FactoryGirl.create :user
      @user.confirm
      sign_in(@user)

      view_response_format

      get :new, { user_id: @user.id }
    end

    it "renders the form for the new image asset" do
      response.should render_template('image_assets/new')
    end
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user = FactoryGirl.create :user
        @user.confirm
        sign_in(@user)
        @image_asset_attributes = FactoryGirl.attributes_for :image_asset

        post :create, { user_id: @user.id, image_asset: @image_asset_attributes }
      end

      # 302 represents the redirection to the new image asset
      it { should respond_with 302 }
    end

    context "when is not created" do
      before(:each) do
        @user = FactoryGirl.create :user
        @user.confirm
        sign_in(@user)
        @invalid_image_asset_attributes = { title: "My Chain", anchor_x: nil, anchor_y: "eight" }

        view_response_format
        post :create, { user_id: @user.id, image_asset: @invalid_image_asset_attributes }
      end

      # Should respond with 200 after redirecting and rendering errors
      it { should respond_with 200 }

      it "renders the template for a new image asset with errors" do
        response.should render_template('image_assets/new')
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @user.confirm
      sign_in(@user)
      @image_asset = FactoryGirl.create :image_asset, user: @user

      view_response_format
      delete :destroy, { user_id: @user.id, id: @image_asset.id }
    end

    # redirect response
    it { should respond_with 302 }
  end

end
