class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.references :library, foreign_key: true
      t.string :event_type
      t.string :remove_reason

      t.timestamps
    end
  end
end
