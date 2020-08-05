class AddRedditIdPropertyToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :reddit_id, :string
    add_index :posts, :reddit_id, unique: true
  end
end
