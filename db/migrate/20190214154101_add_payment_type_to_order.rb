class AddPaymentTypeToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :payment_type, foreign_key: true
  end
end
