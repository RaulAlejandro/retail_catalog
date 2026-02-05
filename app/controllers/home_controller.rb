class HomeController < ApplicationController
  def index
    @featured_products = Product.active.where('stock > 0').limit(6)
    @new_arrivals = Product.active.newest_first.limit(8)
    @categories = Product.all_categories
  end
end
