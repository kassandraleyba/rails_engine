class MerchantSerializer
  def self.format_merchants(merchants)
    merchants.map do |merchant|
      {
        id: merchant.id,
        name: merchant.name
      }
    end
  end

  def self.format_merchant_show(merchant)
    {
      id: merchant.id,
      name: merchant.name
    }
  end
end