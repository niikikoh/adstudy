class TimelinesController < ApplicationController
    before_action :authenticate_user!

    def show
        user_ids = current_user.following.pluck(:id)
        @articles = Article.where(user_id: [current_user.id, *user_ids]).order('updated_at DESC')
    end
end