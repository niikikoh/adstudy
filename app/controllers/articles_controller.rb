class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = Article.all.order('updated_at DESC')
    @profile = current_user.profile
  end
  
  def show
    @article = Article.find(params[:id])
    
    @comments = @article.comments
    @comment = Comment.new

    @like = Like.new 
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to article_path(@article), notice: '記事を保存できました'
    else
      flash.now[:error] = @article.errors.full_messages[0]
      render :new
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])

    if @article.update(article_params)
      redirect_to article_path(@article), notice: '記事を更新できました'
    else
      flash.now[:error] = @article.errors.full_messages[0]
      render :edit
    end
  end

  def destroy
    @articles = current_user.articles.find(params[:id])
    article = Article.find(params[:id])
    article.destroy!
    redirect_to root_path, notice: '削除できました'
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :price, images: [])
  end

end
