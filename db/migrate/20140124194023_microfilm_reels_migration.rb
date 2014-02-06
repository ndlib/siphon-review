class MicrofilmReelsMigration < ActiveRecord::Migration
  def change

    create_table :microfilm_reels do | t |

      t.string :name
      t.string :status
      t.boolean :printed

    end


    create_table :microfilm_volumns do | t |
      t.integer :reformatting_book_id
      t.boolean :partial_programmed
      t.string :print_title
      t.integer :microfilm_reel_id
      t.integer :order

    end
  end
end
