class ProductsController < ApplicationController
  before_action :set_filter_options, only: [:index]

  def index
    @products = ProductFilterService.new(filter_params).call
                  .page(params[:page])
                  .per(6)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @product = Product.active.find(params[:id])
    @related_products = Product.active
                                .by_category(@product.category)
                                .where.not(id: @product.id)
                                .limit(4)
  end

  private

  def filter_params
    params.permit(:query, :category, :brand, :min_price, :max_price, :sort_by, :in_stock_only, :price_range)
  end

  def set_filter_options
    @categories = Product.all_categories
    @brands = Product.all_brands
    @price_ranges = [
      { label: 'Menos de $50', min: 0, max: 50 },
      { label: '$50 - $100', min: 50, max: 100 },
      { label: '$100 - $200', min: 100, max: 200 },
      { label: 'Más de $200', min: 200, max: 999999 }
    ]
  end
end
