class CreateJoinTableLibrarysTags < ActiveRecord::Migration[5.0]
  def change
    create_join_table :libraries, :tags do |t|
      # t.index [:library_id, :tag_id]
      # t.index [:tag_id, :library_id]
    end
  end
end
