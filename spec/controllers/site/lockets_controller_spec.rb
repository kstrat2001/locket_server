require 'spec_helper'

RSpec.describe Site::LocketsController, type: :controller do

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      @locket = FactoryGirl.create :locket, user: @user
      @user.confirm
      sign_in(@user)

      view_response_format

      get :show, { user_id: @user.id, id: @locket.id }
    end

    it "renders the data for a locket record" do
      response.should render_template('lockets/show')
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

    it "renders the form for the new locket" do
      response.should render_template('lockets/new')
    end
  end

  describe "GET #edit" do
    before(:each) do
      @user = FactoryGirl.create :user
      @locket = FactoryGirl.create :locket, user: @user
      @user.confirm
      sign_in(@user)

      view_response_format

      get :edit, { user_id: @user.id, id: @locket.id }
    end

    it "renders the edit form for a locket record" do
      response.should render_template('lockets/edit')
    end
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user = FactoryGirl.create :user
        @user.confirm
        sign_in(@user)
        @locket_attributes = FactoryGirl.attributes_for :locket

        post :create, { user_id: @user.id, locket: @locket_attributes }
      end

      # 302 represents the redirection to the new locket
      it { should respond_with 302 }
    end

    context "when is not created" do
      before(:each) do
        @user = FactoryGirl.create :user
        @user.confirm
        sign_in(@user)
        @invalid_locket_attributes = { title: "My Locket", open_image_id: nil, closed_image_id: nil, mask_image_id: nil, chain_image_id: nil }

        view_response_format
        post :create, { user_id: @user.id, locket: @invalid_locket_attributes }
      end

      # Should respond with 200 after redirecting and rendering errors
      it { should respond_with 200 }

      it "renders the template for a new locket with errors" do
        response.should render_template('lockets/new')
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @user.confirm
      sign_in(@user)
      @locket = FactoryGirl.create :locket, user: @user

      view_response_format
      delete :destroy, { user_id: @user.id, id: @locket.id }
    end

    # redirect response
    it { should respond_with 302 }
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @user.confirm
      sign_in(@user)
      @locket = FactoryGirl.create :locket, user: @user
      @mask_image_id = @locket.mask_image_id
    end

    context "when successfully updated" do
        before(:each) do
          patch :update, { user_id: @user.id, id: @locket.id, locket: { mask_image_id: 20 } }
          @locket = Locket.find(@locket.id)
        end

      it "sets the locket fields as expected" do
        expect(@locket.mask_image_id).to eql 20
      end
    end
  end

end
