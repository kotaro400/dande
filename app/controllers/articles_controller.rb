class ArticlesController < ApplicationController
  before_action :authenticate_owner!, except: [:index, :show, :search]

  def index
    @articles = Article.on_public
    @tags = Tag.all
  end

  def show
    @article = Article.find(params[:id])
    if !current_owner && !@article.public
      redirect_to root_path
      return
    end
  end

  def new
    @article = Article.new
    @tags = Tag.all
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
    @tags = Tag.all
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
    if params[:word]
      @articles = Article.search(params[:word])
      @word = params[:word]
    elsif params[:for_engineer] && params[:for_designer]
      @articles = Article.for_designer_or_designer
    elsif params[:for_engineer]
      @articles = Article.for_engineer
    elsif params[:for_designer]
      @articles = Article.for_designer
    elsif params[:tag]
      @articles = Tag.find_by(name: params[:tag]).articles
      @word = params[:tag]
    else
      @articles = Article.on_public
    end
  end

  def embed
    @article = Article.find_by(id: params[:id])
  end

  def preview
    @article = Article.find_by(id: params[:id])
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :for_engineer, :for_designer, :image, :public)
  end
end
