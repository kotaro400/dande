class TagsController < ApplicationController
  before_action :authenticate_owner!

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(name: params[:tag][:name])
    if @tag.save
      render "create"
    else
      render "error"
    end
  end

  def search
    @tags = Tag.search(params[:word])
  end
end
