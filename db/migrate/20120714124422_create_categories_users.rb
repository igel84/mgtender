class CreateCategoriesUsers < ActiveRecord::Migration
  def change
    create_table :categories_users, id: false do |t|
      t.integer :user_id, null: false
      t.integer :category_id, null: false

      t.timestamps
    end
  end
end
