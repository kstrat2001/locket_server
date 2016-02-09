class Api::V1::LocketsController < ApplicationController
  respond_to :json

  def show
    respond_with Locket.find(params[:id])
  end

  def index
    respond_with Locket.all
  end

end
