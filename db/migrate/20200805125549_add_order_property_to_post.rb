class AddOrderPropertyToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :order, :integer
  end
end
