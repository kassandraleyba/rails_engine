class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def self.search_by_name(query)
    where("name ILIKE ?", "%#{query}%").order(:name)
  end
end
