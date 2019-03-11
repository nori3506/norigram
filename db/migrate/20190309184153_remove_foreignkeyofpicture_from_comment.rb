class RemoveForeignkeyofpictureFromComment < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :comments, :picture_id
  end
end
