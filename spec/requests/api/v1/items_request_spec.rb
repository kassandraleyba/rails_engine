require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_data[:data]).to be_an Array
    expect(parsed_data[:data].size).to eq(3)
    expect(parsed_data[:data][0].keys).to eq([:id, :type, :attributes])
    expect(parsed_data[:data][0][:attributes][:name]).to eq(Item.first.name)
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_data[:data]).to be_a Hash
    expect(parsed_data[:data].size).to eq(3)
    expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
    expect(parsed_data[:data][:id]).to eq(Item.first.id.to_s)
    expect(parsed_data[:data][:attributes]).to eq({name: Item.first.name, 
                                                  description: Item.first.description, 
                                                  unit_price: Item.first.unit_price, 
                                                  merchant_id: Item.first.merchant_id})
    expect(parsed_data[:data][:attributes].size).to eq(4)
  end

  it "can create a new item" do
    id = create(:merchant).id

    item_params = ({
                  name: "New Item",
                  description: "New Description",
                  unit_price: 100.00,
                  merchant_id: id
                })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful

    expect(created_item[:name]).to eq(item_params[:name])
    expect(created_item[:description]).to eq(item_params[:description])
    expect(created_item[:unit_price]).to eq(item_params[:unit_price])
    expect(created_item[:merchant_id]).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "New Item Name" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful

    expect(item[:name]).to_not eq(previous_name)
    expect(item[:name]).to eq("New Item Name")
    expect(item[:description]).to eq(Item.last.description)
    expect(item[:unit_price]).to eq(Item.last.unit_price)
    expect(item[:merchant_id]).to eq(Item.last.merchant_id)
  end

  it "errors when updating an item with invalid params" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to_not be_successful

    expect(response).to have_http_status(400)
    expect(response).to have_http_status(:bad_request)

    error = JSON.parse(response.body, symbolize_names: true)
    expect(error[:errors]).to eq("Invalid Update")
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)
  
    delete "/api/v1/items/#{item.id}"
  
    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can get the merchant associated with an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_data[:data]).to be_a Hash
    expect(parsed_data[:data].size).to eq(3)
    expect(parsed_data[:data].keys).to eq([:id, :type, :attributes])
    expect(parsed_data[:data][:id]).to eq(Merchant.first.id.to_s)
    expect(parsed_data[:data][:type]).to eq("merchant")
    expect(parsed_data[:data][:attributes]).to eq({name: Merchant.first.name})
  end

  describe 'Non-RESTful API endpoints' do
    it 'can find an item by name' do
      merchant = create(:merchant)
      item1 = create(:item, name: "tea", merchant_id: merchant.id)
      item2 = create(:item, name: "coffee", merchant_id: merchant.id)
      item3 = create(:item, name: "matcha", merchant_id: merchant.id)

      get "/api/v1/items/find?name=tea"
      
      parsed_data = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
    end
  end
end