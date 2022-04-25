class Api::V1::UserController < ApplicationController
  def create
    if params[:password] != params[:password_confirmation]
      render json: { data: { message: 'passwords do not match' } }
    elsif User.find_by(email: params[:email])
      render json: { data: { message: 'that email already exists' } }
    else
      if  user = User.create(user_params)
          render json: UserSerializer.new(user)
      else
        render json: { data: { message: 'unable to create user' } }, status: :bad_request
      end
    end

  end

  private
  def user_params
    params.permit(:email, :password)
  end
end
