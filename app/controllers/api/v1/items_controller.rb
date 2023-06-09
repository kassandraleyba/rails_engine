class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: 201
    else
      # render json: ErrorSerializer.new(item).serialized_json, status: 400
      render json: { errors: "Invalid Create" }, status: 400
    end
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      render json: ItemSerializer.new(item)
    else
      render json: { errors: "Invalid Update" }, status: 400
    end
  end

  def destroy
    render json: ItemSerializer.new(Item.destroy(params[:id]))
  end

  private 

  def item_params
    params.required(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end