class UsersController < ApplicationController::Base64

  private
  def user_params
    params.require(:user).permit(:name)
  end


end
