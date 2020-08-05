class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :author
      t.datetime :entry_date
      t.integer :comments
      t.string :status

      t.timestamps
    end
  end
end
