class CreateProposeItems < ActiveRecord::Migration
  def change
    create_table :propose_items do |t|
      t.integer :propose_id
      t.integer :tender_item_id
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
