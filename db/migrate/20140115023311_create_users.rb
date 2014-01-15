class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
    add_column :users, :password_digest, :string
    add_index :users, :email, unique: true
    add_column :users, :admin, :boolean, default: false
  end
end
