class AccountsController < ApplicationController
    def show
        @user = User.find(params[:id])
        @profile = @user.prepare_profile
        @articles = @user.articles.all.order('updated_at DESC')
        redirect_to profile_path if @user == current_user
    end
end