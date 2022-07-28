class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def show
    @stock_count = Product.sum(:quantity)
    @categories_count = Category.count(:id)
    puts @categories_count
  end
end
