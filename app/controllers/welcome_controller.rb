class WelcomeController < ApplicationController

  def index
    if current_user
      redirect_to site_user_path(current_user)
    end
  end

end
