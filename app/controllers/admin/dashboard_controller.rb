class Admin::DashboardController < Admin::BaseController

  def show
    @stock_count = Product.sum(:quantity)
    @categories_count = Category.count(:id)
  end
end
