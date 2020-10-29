class EmbeddedArticlesController < ApplicationController
  before_action :authenticate_owner!, except: [:show, :embed]

  def show
    @article = Article.find_by(id: params[:id])
  end

  def embed
    @article = Article.find_by(id: params[:id])
  end
  
end
