class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.format_items(Item.all)
  end

  def show
    render json: ItemSerializer.format_item(Item.find(params[:id]))
  end
end