require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { should belong_to :customer }
  it { should belong_to :merchant }
  it { should have_many :transactions }
  it { should have_many :invoice_items }
  it { should have_many(:items).through(:invoice_items) }

  it { should validate_presence_of :status }
end
