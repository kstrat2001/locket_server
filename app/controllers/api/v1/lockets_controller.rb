class Api::V1::LocketsController < ApplicationController
  respond_to :json

  def show
    respond_with Locket.find(params[:id])
  end

  def index
    if params[:workflow_state]
      respond_with Locket.where("workflow_state = ?", params[:workflow_state])
    else
      respond_with Locket.all
    end
  end

end
