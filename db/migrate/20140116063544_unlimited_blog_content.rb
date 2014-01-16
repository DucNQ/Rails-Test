class UnlimitedBlogContent < ActiveRecord::Migration
  def change
  	change_column :entries, :body, :text, limit: nil
  end
end
