class Api::V1::ImageAssetsController < ApplicationController
  respond_to :json

  def show
    respond_with ImageAsset.find(params[:id])
  end

  def index
    respond_with ImageAsset.all
  end

  def create
    image_asset = authorized_user.image_assets.build(image_asset_params)
    if image_asset.save
      render json: image_asset, status: 201, location: [:api, image_asset]
    else
      render json: { errors: image_asset.errors }, status: 422
    end
  end

  def update
    image_asset = authorized_user.image_assets.find(params[:id])
    if image_asset.update(image_asset_params)
      render json: image_asset, status: 200, location: [:api, image_asset]
    else
      render json: { errors: image_asset.errors }, status: 422
    end
  end

  def image_asset_params
    params.require(:image_asset).permit(:title, :anchor_x, :anchor_y, :image)
  end

  def destroy
    image_asset = authorized_user.image_assets.find(params[:id])
    image_asset.destroy 
    head 204 
  end

end
