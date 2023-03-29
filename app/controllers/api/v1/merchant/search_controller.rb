class Api::V1::Merchant::SearchController < ApplicationController
  def index
    merchant = Merchant.search_by_name(params[:name])
    if merchant.empty?
      render json: { errors: "Invalid Search" }
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end