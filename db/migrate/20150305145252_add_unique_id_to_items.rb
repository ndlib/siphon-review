class AddUniqueIdToItems < ActiveRecord::Migration
  def change
    add_column :reformatting_books, :unique_id, :string
    add_index :reformatting_books, :unique_id
  end
end
