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
    Merchant.find(item_params[:merchant_id])
    Item.create(item_params)
    render json: ItemSerializer.format_item(Item.last)
  end

  private 

  def item_params
    params.required(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end