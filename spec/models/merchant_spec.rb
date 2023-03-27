require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many :items }
  it { should have_many :invoices }
  it { should have_many(:customers).through(:invoices) }
  it { should have_many(:transactions).through(:invoices) }
  
  it { should validate_presence_of :name }
end
