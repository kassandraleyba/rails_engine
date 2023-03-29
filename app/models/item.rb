class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.search_by_name(query)
    where("name ILIKE ?", "%#{query}%").order(name: :asc).limit(1)
    # we want to order by name alphabetically

    # ILIKE is case insensitive
    # LIKE is case sensitive
    # ? is a placeholder for the query
    # % is a wildcard, it matches any number of characters (also a partial)
  end
end