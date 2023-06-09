require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
   
    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_data[:data]).to be_an Array
    expect(parsed_data[:data].size).to eq(3)
    expect(parsed_data[:data][0].keys).to eq([:id, :type, :attributes])
    expect(parsed_data[:data][0][:attributes][:name]).to eq(Merchant.first.name)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_data[:data]).to be_a Hash
    expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
    expect(parsed_data[:data][:id]).to eq(Merchant.first.id.to_s)
    expect(parsed_data[:data][:type]).to eq("merchant")
    expect(parsed_data[:data][:attributes]).to eq({name: Merchant.first.name})
    expect(parsed_data[:data][:attributes].size).to eq(1)
  end

  it "can get all items for a given merchant ID" do
    id = create(:merchant).id
    
    create_list(:item, 3, merchant_id: id)

    get "/api/v1/merchants/#{id}/items"

    parsed_data = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
    
    expect(parsed_data[:data]).to be_an Array
    expect(parsed_data[:data].size).to eq(3)
    expect(parsed_data[:data][0].keys).to eq([:id, :type, :attributes])
    expect(parsed_data[:data][0][:id]).to eq(Item.first.id.to_s)
    expect(parsed_data[:data][0][:type]).to eq("item")
    expect(parsed_data[:data][0][:attributes]).to eq({name: Item.first.name, 
                                                  description: Item.first.description, 
                                                  unit_price: Item.first.unit_price, 
                                                  merchant_id: Item.first.merchant_id})
    expect(parsed_data[:data][0][:attributes].size).to eq(4)
  end

  describe "Non-RESTful API endpoints" do
    it "can find all merchants by name" do
      merchant1 = create(:merchant, name: "yogi tea")
      merchant2 = create(:merchant, name: "numi tea")
      merchant3 = create(:merchant, name: "peets coffee")

      get "/api/v1/merchants/find_all?name=tea"

      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(response).to be_successful
      expect(parsed_data[:data]).to be_a Array
      expect(parsed_data[:data].size).to eq(2)
      expect(parsed_data[:data][0].keys).to eq([:id, :type, :attributes])
      expect(parsed_data[:data][0][:id]).to eq(merchant2.id.to_s)
    end

    it "cannot find merchants by name if it doesn't exist" do
      merchant1 = create(:merchant, name: "yogi tea")

      get "/api/v1/items/find?name=coffee"
      
      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
      expect(parsed_data[:errors]).to eq("Invalid Search") 
    end
  end
end