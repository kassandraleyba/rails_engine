require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many :items }
  it { should have_many :invoices }
  it { should have_many(:customers).through(:invoices) }
  it { should have_many(:transactions).through(:invoices) }
  
  it { should validate_presence_of :name }

  describe 'class methods' do
    it '#can find merchants by name' do
      merchant1 = create(:merchant, name: "yogi tea")
      merchant2 = create(:merchant, name: "numi tea")
      merchant3 = create(:merchant, name: "peets coffee")

      expect(Merchant.search_by_name("tea")).to eq([merchant2, merchant1])
      expect(Merchant.search_by_name("E")).to eq([merchant2, merchant3, merchant1])
      expect(Merchant.search_by_name("i")).to eq([merchant2, merchant1])
    end

    it "#cannot find merchants by name if it doesn't exist" do
      merchant1 = create(:merchant, name: "tea")

      expect(Merchant.search_by_name("coffee")).to_not eq([merchant1])
    end
  end
end
