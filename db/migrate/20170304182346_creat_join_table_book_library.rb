class CreatJoinTableBookLibrary < ActiveRecord::Migration[5.0]
  def change
    create_join_table :books, :libraries do |t|
      # t.index [:book_id, :library_id]
      # t.index [:library_id, :book_id]
    end
  end
end
