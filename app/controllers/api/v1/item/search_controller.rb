class Api::V1::Item::SearchController < ApplicationController
  def show
    # created a route that routes to show controller
    # and allowing this route to pass in params
    # next step is to create the class method in the model to find the item name
    #conditional statement to render json
    if params[:name]
      search_item_name
    elsif params[:min_price]
      search_item_price_min
    elsif params[:max_price]
      search_item_price_max
    elsif params[:min_price] && params[:max_price]
      search_item_price_min_max
    else
      render json: { errors: "Invalid Search" }, status: 400
    end
  end

  def search_item_name
    item = Item.search_by_name(params[:name])
    if item.nil?
      render json: { data: {}}, status: 400
    else
      render json: ItemSerializer.new(item)
    end
  end

  def search_item_price_min
    item = Item.search_min_price(params[:min_price])

    if item.empty?
      render json: { errors: "Invalid Search" }, status: 400
    else
      render json: ItemSerializer.new(item)
    end
  end

  def search_item_price_max
    item = Item.search_max_price(params[:max_price]) 

    if item.empty?
      render json: { errors: "Invalid Search" }, status: 400
    else
      render json: ItemSerializer.new(item)
    end
  end

  def search_item_price_min_max
    puts "search_item_price_min_max called"
    item = Item.search_min_max_price(params[:min_price], params[:max_price])

    if item.empty?
      render json: { errors: "Invalid Search" }, status: 400
    else
      render json: ItemSerializer.new(item)
    end
  end
  puts "search_item_price_min_max finished"
end