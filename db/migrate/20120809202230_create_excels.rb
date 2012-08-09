class CreateExcels < ActiveRecord::Migration
  def change
    create_table :excels do |t|
      t.string :name
      t.integer :user_id
      t.string :content_type
      t.binary :data, limit: 1.megabyte

      t.timestamps
    end
  end
end
