class AddTermToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :term, :boolean, default: false, null: false
  end
end
