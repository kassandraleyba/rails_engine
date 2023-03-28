class ItemSerializer
  def self.format_items(items)
    items.map do |item|
      {
        id: item.id,
        name: item.name,
        description: item.description,
        unit_price: item.unit_price,
        merchant_id: item.merchant_id
      }
    end
  end

  def self.format_item(item)
    {
      id: item.id,
      name: item.name,
      description: item.description,
      unit_price: item.unit_price,
      merchant_id: item.merchant_id
    }
  end
end