require 'spec_helper'

describe WelcomeController do

  before(:each) do
    #set up the accept header to allow html responses
    view_response_format
  end

  describe "GET index" do
    it "renders the welcome index page" do
      get :index
      response.should render_template('welcome/index')
    end
  end
end
