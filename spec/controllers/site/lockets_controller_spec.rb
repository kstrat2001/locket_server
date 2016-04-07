require 'spec_helper'

RSpec.describe Site::LocketsController, type: :controller do

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      @image = FactoryGirl.create :image_asset, user: @user
      @locket = FactoryGirl.create :locket, user: @user, open_image_id: @image.id, closed_image_id: @image.id, chain_image_id: @image.id, mask_image_id: @image.id
      @user.confirm
      sign_in(@user)

      view_response_format
      get :show, { user_id: @user.id, id: @locket.id }
    end

    it "renders the data for a locket record" do
      expect render_template('lockets/show')
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
      expect render_template('lockets/new')
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
      expect render_template('lockets/edit')
    end
  end

  describe "Workflow new" do
      before(:each) do
          @user = FactoryGirl.create :user
          @locket = FactoryGirl.create :locket, user: @user
      end

      it "has state new" do
          expect(@locket.new?).to eql true
          expect(@locket.waiting_for_review?).to eql false
          expect(@locket.in_review?).to eql false
          expect(@locket.accepted?).to eql false
          expect(@locket.rejected?).to eql false
      end
  end

  describe "Locket Workflow" do
      before(:each) do
          @user = FactoryGirl.create :user
          @locket = FactoryGirl.create :locket, user: @user
          @user.confirm
          sign_in(@user)

      end

      context "when created" do
          before(:each) do
              @locket = Locket.find(@locket.id)
          end

          it "has state new" do
            expect(@locket.new?).to eql true
          end
      end

      context "when submitted" do
          before(:each) do
            patch :submit, { user_id: @user.id, id: @locket.id }
            @locket = Locket.find(@locket.id)
          end

          it "has state waiting_for_review" do
              expect(@locket.waiting_for_review?).to eql true
          end
      end

      context "when submitted and reviewed" do
          before(:each) do
            patch :submit, { user_id: @user.id, id: @locket.id }
            patch :review, { user_id: @user.id, id: @locket.id }
            @locket = Locket.find(@locket.id)
          end

          it "has state in_review" do
              expect(@locket.in_review?).to eql true
          end
      end

      context "when submitted and reviewed and accepted" do
          before(:each) do
            patch :submit, { user_id: @user.id, id: @locket.id }
            patch :review, { user_id: @user.id, id: @locket.id }
            patch :accept, { user_id: @user.id, id: @locket.id }
            @locket = Locket.find(@locket.id)
          end

          it "has state in_review" do
              expect(@locket.accepted?).to eql true
          end
      end

      context "when submitted and reviewed and rejected" do
          before(:each) do
            patch :submit, { user_id: @user.id, id: @locket.id }
            patch :review, { user_id: @user.id, id: @locket.id }
            patch :reject, { user_id: @user.id, id: @locket.id }
            @locket = Locket.find(@locket.id)
          end

          it "has state rejected" do
              expect(@locket.rejected?).to eql true
          end
      end

      context "when submitted and reviewed and rejected and resubmitted" do
          before(:each) do
            patch :submit, { user_id: @user.id, id: @locket.id }
            patch :review, { user_id: @user.id, id: @locket.id }
            patch :reject, { user_id: @user.id, id: @locket.id }
            patch :resubmit, { user_id: @user.id, id: @locket.id }
            @locket = Locket.find(@locket.id)
          end

          it "has state waiting_for_review" do
              expect(@locket.waiting_for_review?).to eql true
          end
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
        expect render_template('lockets/new')
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
