class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]
  respond_to :json

  def show
    user = User.find(params[:id]) or not_found
    respond_with user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = authorized_user
    user.skip_reconfirmation!
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = authorized_user
    user.destroy
    head 204
  end

private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
