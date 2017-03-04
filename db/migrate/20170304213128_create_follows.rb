class CreateFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :follows do |t|
      t.references :follower
      t.references :followee
      
      t.timestamps
    end
  end
end
