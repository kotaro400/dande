class ArticlesController < ApplicationController
  before_action :redirect_unless_owner, except: [:index, :show, :search]

  def index
    @articles = Article.on_public
  end

  def show
    @article = Article.find(params[:id])
    if !current_owner && !@article.open
      redirect_to root_path
      return
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.tags = Tag.where(id: params[:tags]&.map{|id| id.to_i })
    @article.feature = Feature.find_by(id: params[:article][:feature].to_i)
    if @article.save
      redirect_to articles_path
    else
      render "new"
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.tags = Tag.where(id: params[:tags]&.map{|id| id.to_i })
    @article.feature = Feature.find_by(id: params[:article][:feature].to_i)
    if @article.update(article_params)
      redirect_to articles_path
    else
      render "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.image.purge
    @article.destroy
    redirect_to root_path
  end

  def draft
    @articles = Article.draft
  end

  def search
    @articles = Article.filter(params)
    @word = params[:word] if params[:word]
    @word = params[:tag] if params[:tag]
    respond_to do |format|
      format.html {render "index"}
      format.js {render "search"}
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :open, :for_engineer, :for_designer, :image)
  end
end
