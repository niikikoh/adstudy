class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.build(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            flash[:notice] = 'コメントしました'
            redirect_to article_path(@article)
        else
            flash[:error] = 'コメントに失敗しました'
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
