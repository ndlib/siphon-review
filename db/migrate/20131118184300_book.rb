class Book < ActiveRecord::Migration
  def change

    create_table :reformatting_books do | t |
      t.string :status
      t.string :title
      t.string :call_number
      t.string :category
      t.string :barcode
      t.string :document_number
      t.text :data
    end

    add_index :reformatting_books, :status
    add_index :reformatting_books, :document_number
  end
end
