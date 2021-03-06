class LikesController < ApplicationController

    def show
        article = Article.find(params[:article_id])
        like_status = current_user.already_liked?(article)
        render json: { alreadyLiked: like_status }
    end

    def create
        @like = current_user.likes.create(article_id: params[:article_id])
        render json: { status: 'ok' }
    end

    def destroy
        @like = Like.find_by(article_id: params[:article_id], user_id: current_user.id)
        @like.destroy!
        render json: { status: 'ok' }
    end
end
