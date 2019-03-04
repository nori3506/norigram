class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :website, :string
    add_column :users, :introduction, :string
    add_column :users, :tel, :string
    add_column :users, :gender, :string
  end
end
