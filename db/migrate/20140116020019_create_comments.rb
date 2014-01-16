class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :entry_id

      t.timestamps
    end
    add_index :comments, [:entry_id, :created_at]
  end
end
