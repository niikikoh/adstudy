class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.build(comment_params)
        @comment.user_id = current_user.id
        @comment.save!

        redirect_to @article
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
