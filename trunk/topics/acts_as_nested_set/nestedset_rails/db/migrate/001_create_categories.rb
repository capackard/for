class AddCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :parent_id, :int
      t.column :lft, :int
      t.column :rgt, :int
      t.column :name, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :categories
  end
end
