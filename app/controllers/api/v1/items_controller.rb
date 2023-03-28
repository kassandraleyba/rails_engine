class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.format_items(Item.all)
  end
end