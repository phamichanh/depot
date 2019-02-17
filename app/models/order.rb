require 'active_model/serializers/xml'
class Order < ApplicationRecord
  include ActiveModel::Serializers::Xml

  has_many :line_items, dependent: :destroy
  belongs_to :payment_type

  validates :name, :address, :email, presence: true
  validates_associated :payment_type

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

end
