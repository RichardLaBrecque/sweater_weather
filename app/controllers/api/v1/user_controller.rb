class Api::V1::UserController < ApplicationController
  def create
    if !params[:password] || !params[:password_confirmation] || !params[:email]
      render json: { data: { message: 'unable to create user' } }, status: :bad_request
    elsif params[:password] != params[:password_confirmation]
      render json: { data: { message: 'passwords do not match' } }, status: :bad_request
    elsif User.find_by(email: params[:email])
      render json: { data: { message: 'that email already exists' } }, status: :bad_request
    else
      user = User.create(user_params)
      render json: UserSerializer.new(user)
    end

  end

  def login
    user = User.find_by(email: params[:email])
    if user.nil?
      render json: {data: {message: "well thats not right, try something different"}}, status: :bad_request
    elsif user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
        render json: {data: {message: "well thats not right, try something different"}}, status: :bad_request
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end
end
