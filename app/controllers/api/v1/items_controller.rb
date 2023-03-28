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
    Item.create(item_params)
    # if item.save
    render json: ItemSerializer.new(Item.last), status: 201
    # else
      # render json: {error: "Item not created"}, status: 400
    # end
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    render json: ItemSerializer.new(Item.destroy(params[:id]))
  end

  private 

  def item_params
    params.required(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end