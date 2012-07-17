class CreateTenders < ActiveRecord::Migration
  def change
    create_table :tenders do |t|
      t.integer :user_id
      t.string :category_id
      t.datetime :start_at
      t.datetime :end_at
      t.string :name
      t.integer :status, default: 0
      t.integer :iteration_count, default: 1
      t.text :note
      t.integer :tender_type_id
      t.decimal :step, precision: 10, scale: 2
      t.boolean :closed, default: false
      t.decimal :summ, precision: 10, scale: 2

      t.timestamps
    end
  end
end
