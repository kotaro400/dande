class FeaturesController < ApplicationController
  before_action :redirect_unless_owner, only: [:new, :create, :edit, :update, :destroy]

  def index
    @features = Feature.sort_from_newest_to_oldest
  end

  def show
    @feature = Feature.find(params[:id])
  end

  def new
    @feature = Feature.new
  end

  def create
    @feature = Feature.new(feature_params)
    if @feature.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit
    @feature = Feature.find(params[:id])
  end

  def update
    @feature = Feature.find(params[:id])
    if @feature.update(feature_params)
      redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    @feature = Feature.find(params[:id])
    @feature.image.detach if @feature.image.attached?
    @feature.articles.each{|article| article.update(feature_id: nil)}
    @feature.destroy
    redirect_to root_path
  end

  private
  def feature_params
    params.require(:feature).permit(:title, :details, :for_engineer, :for_designer, :image)
  end
end
