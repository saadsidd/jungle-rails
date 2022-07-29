class Admin::BaseController < ApplicationController
  # base controller for admin auth filter. other admin controllers inherit from this
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']
end