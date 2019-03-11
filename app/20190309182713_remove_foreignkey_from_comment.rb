class RemoveForeignkeyFromComment < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :comments, :user_id
  end
end
