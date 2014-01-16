class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :body
      t.integer :user_id

      t.timestamps
    end 
    add_index :entries, [:user_id, :created_at]
  end
end
