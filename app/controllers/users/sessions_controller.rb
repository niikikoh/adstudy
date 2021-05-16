# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def new
    super
  end

  def create
    super
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    if user.save
      redirect_to root_path
      flash[:notice] = 'ゲストユーザーとして登録しました'
    else
      flash.now[:error] = 'ゲストユーザとして登録できませんでいた'
      render :new
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
