class Api::V1::Item::SearchController < ApplicationController
  def show
    # created a route that routes to show controller
    # and allowing this route to pass in params
    # next step is to create the class method in the model to find the item name
    item = Item.search_by_name(params[:name])
    render json: ItemSerializer.new(item)
  end
end