require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to :merchant }
  it { should have_many :invoice_items }
  it { should have_many(:invoices).through(:invoice_items) }
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :unit_price }

  describe 'class methods' do
    it '#can find an item by name' do
      merchant = create(:merchant)
      item1 = create(:item, name: "tea", merchant_id: merchant.id)
      item2 = create(:item, name: "coffee", merchant_id: merchant.id)
      item3 = create(:item, name: "matcha", merchant_id: merchant.id)

      expect(Item.search_by_name("tea")).to eq([item1])
      expect(Item.search_by_name("E")).to eq([item2])
      expect(Item.search_by_name("a")).to eq([item3])
    end
  end
end
