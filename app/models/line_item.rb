class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end

  def decrement_quantity
    if quantity > 1
      decrement!(:quantity)
    else
      destroy
    end

  end

  def increment_quantity
    increment!(:quantity)
  end
end
