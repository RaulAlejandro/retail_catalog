class ProductFilterService
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def call
    products = Product.active

    products = apply_search(products)
    products = apply_category_filter(products)
    products = apply_brand_filter(products)
    products = apply_price_filter(products)
    products = apply_stock_filter(products)
    products = apply_sorting(products)

    products
  end

  private

  def apply_search(products)
    return products if params[:query].blank?
    products.search_by_text(params[:query])
  end

  def apply_category_filter(products)
    return products if params[:category].blank?
    products.by_category(params[:category])
  end

  def apply_brand_filter(products)
    return products if params[:brand].blank?
    products.by_brand(params[:brand])
  end

  def apply_price_filter(products)
    # Handle price_range parameter (e.g., "0-50")
    if params[:price_range].present?
      min, max = params[:price_range].split('-').map(&:to_i)
      return products.price_range(min, max)
    end

    # Handle individual min_price and max_price parameters
    return products if params[:min_price].blank? || params[:max_price].blank?
    products.price_range(params[:min_price], params[:max_price])
  end

  def apply_stock_filter(products)
    return products unless params[:in_stock_only] == '1'
    products.in_stock
  end

  def apply_sorting(products)
    case params[:sort_by]
    when 'price_asc'
      products.price_low_to_high
    when 'price_desc'
      products.price_high_to_low
    else
      products.newest_first
    end
  end
end
