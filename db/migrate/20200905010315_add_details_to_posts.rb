class AddDetailsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :area, :string
    add_column :posts, :genre, :string
    add_column :posts, :season, :string
  end
end
