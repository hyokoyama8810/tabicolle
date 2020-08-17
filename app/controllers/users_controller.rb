class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]


  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

end
