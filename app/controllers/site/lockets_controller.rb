class Site::LocketsController < ApplicationController
  def show
    @locket = Locket.find(params[:id])
  end

  def new
    @user = current_user
    @locket = Locket.new
    @action = "create"
  end

  def edit
    @user = current_user
    @locket = current_user.lockets.find(params[:id])
    @action = "update"
  end

  def create
    @user = current_user
    @locket = current_user.lockets.build(locket_params)
    @action = "create"

    if @locket.save
      redirect_to site_user_locket_path(current_user, @locket)
    else
      render :new
    end
  end

  def update
    @locket = current_user.lockets.find(params[:id])
    if @locket.update(locket_params)
      redirect_to site_user_locket_path(current_user, @locket)
    else
      render site_user_locket_path(current_user, @locket) 
    end
  end

  def destroy
    @locket = current_user.lockets.find(params[:id])
    @locket.destroy
    redirect_to site_user_path(current_user)
  end

  def locket_params
    params.require(:locket).permit(:title, :open_image_id, :closed_image_id, :mask_image_id, :chain_image_id, :image)
  end
end
