class Product < ApplicationRecord
  # Serialización de tags como array
  serialize :tags, type: Array, coder: JSON

  validates :product_id, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 }
  validates :category, presence: true
  validates :brand, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Scopes para filtrado
  scope :active, -> { where(active: true) }
  scope :in_stock, -> { where('stock > ?', 0) }
  scope :by_brand, ->(brand_name) { where(brand: brand_name) if brand_name.present? }
  scope :by_category, ->(category_name) { where(category: category_name) if category_name.present? }
  scope :price_range, ->(min, max) {
    where('price >= ?', min).where('price <= ?', max) if min.present? && max.present?
  }

  # Búsqueda full-text
  include PgSearch::Model
  pg_search_scope :search_by_text,
    against: { name: 'A', description: 'B' },
    using: { tsearch: { prefix: true, dictionary: 'english' } }

  # Ordenamiento
  scope :newest_first, -> { order(created_at: :desc) }
  scope :price_low_to_high, -> { order(price: :asc) }
  scope :price_high_to_low, -> { order(price: :desc) }

  # Métodos helper
  def in_stock?
    stock > 0
  end

  def formatted_price
    "$#{price.round(2)}"
  end

  def formatted_old_price
    old_price.present? ? "$#{old_price.round(2)}" : nil
  end

  def discount_percentage
    return nil unless old_price.present? && old_price > price
    (((old_price - price) / old_price) * 100).round(0)
  end

  def has_discount?
    old_price.present? && old_price > price
  end

  # Métodos de clase para obtener valores únicos
  def self.all_categories
    distinct.pluck(:category).sort
  end

  def self.all_brands
    distinct.pluck(:brand).sort
  end
end
