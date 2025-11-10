class UsersController < ApplicationController
  def index
    @users = User.includes(:reviews).page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.includes(:meal).order(created_at: :desc)
  end
end