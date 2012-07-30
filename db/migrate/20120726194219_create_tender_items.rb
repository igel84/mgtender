class CreateTenderItems < ActiveRecord::Migration
  def change
    create_table :tender_items do |t|
      t.integer :tender_id
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.float :count, default: 1

      t.timestamps
    end
  end
end
