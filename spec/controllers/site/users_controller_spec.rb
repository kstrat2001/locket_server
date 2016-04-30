require 'spec_helper'

describe Site::UsersController do

  before(:each) do
    #set up the accept header to allow html responses
    view_response_format

    @user = FactoryGirl.create(:user)
    @user.confirm
    sign_in(@user)
  end

  describe "GET show" do
    before(:each) do
      get :show, id: @user.id
    end

    it "renders the user page" do
      response.should render_template('users/show')
    end
  end

  describe "GET admin" do
    before(:each) do
      get :admin, id: @user.id
    end

    it "renders the user admin page" do
      response.should render_template('users/admin')
    end
  end

end
