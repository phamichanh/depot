class RemovePayTypeFromOrders < ActiveRecord::Migration[5.2]
  def up
    remove_column :orders, :pay_type, :string
  end

  def down
    add_column :orders, :pay_type, :string
  end
end
