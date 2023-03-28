class Api::V1::Item::MerchantController < ApplicationController
  def show
    merchant = Item.find(params[:item_id]).merchant
    render json: MerchantSerializer.format_merchant_show(merchant)
  end
end