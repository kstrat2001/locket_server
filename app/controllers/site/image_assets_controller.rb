class Site::ImageAssetsController < ApplicationController
  def show
    @asset = ImageAsset.find(params[:id])
  end

  def new
    @user = current_user
    @image_asset = ImageAsset.new
  end

  def create
    @user = current_user
    @image_asset = current_user.image_assets.build(image_asset_params)
    if @image_asset.save
      redirect_to site_user_image_asset_path(current_user, @image_asset)
    else
      render :new
    end
  end

  def destroy
    @image_asset = current_user.image_assets.find(params[:id])
    @image_asset.destroy
    redirect_to site_user_path(current_user)
  end

  def image_asset_params
    params.require(:image_asset).permit(:title, :anchor_x, :anchor_y, :image)
  end
end

