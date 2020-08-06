class ChangeStatusColumnInPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :status
    add_column :posts, :read, :boolean, default: false
  end
end
