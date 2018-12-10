class AddIndexToProducts < ActiveRecord::Migration
  def change
    add_index :products, :title
  end
end
