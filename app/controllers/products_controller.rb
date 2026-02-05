class ProductsController < ApplicationController

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


end
