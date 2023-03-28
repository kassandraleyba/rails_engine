class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all
    render json: ItemSerializer.format_items(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.format_item(item)
  end

  def create
    Item.create(item_params)
    render json: ItemSerializer.format_item(Item.last)
  end

  def update
    render json: ItemSerializer.format_item(Item.update(params[:id], item_params))
  end

  def destroy
    render json: ItemSerializer.format_item(Item.destroy(params[:id]))
  end

  private 

  def item_params
    params.required(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end