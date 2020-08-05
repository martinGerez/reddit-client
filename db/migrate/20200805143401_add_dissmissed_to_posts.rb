class AddDissmissedToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :dissmissed, :boolean, default: false
  end
end
