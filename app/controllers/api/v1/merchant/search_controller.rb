class Api::V1::Merchant::SearchController < ApplicationController
  def index
    merchant = Merchant.search_by_name(params[:name])
    render json: MerchantSerializer.new(merchant)
  end
end