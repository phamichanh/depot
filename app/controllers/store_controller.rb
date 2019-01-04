class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    get_access_time
    @products = Product.order(:title)
  end
  def get_access_time
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
    @access_time = session[:counter]
  end

end
