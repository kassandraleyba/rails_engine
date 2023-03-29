class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.search_by_name(query)
    where("name ILIKE ?", "%#{query}%").order(name: :asc).first
    # order by name alphabetically
    # can't do limit(1) because it adds into an array

    # ILIKE is case insensitive
    # LIKE is case sensitive
    # ? is a placeholder for the query
    # % is a wildcard, it matches any number of characters (also a partial)
  end

  # def self.search_min_price

  # end

  # def self.search_max_price

  # end

  # def self.search_min_max_price

  # end
end