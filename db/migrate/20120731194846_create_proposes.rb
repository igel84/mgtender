class CreateProposes < ActiveRecord::Migration
  def change
    create_table :proposes do |t|
      t.integer :tender_id
      t.integer :tender_iteration_id
      t.integer :user_id
      t.text :note
      t.integer :delay, default: 0
      t.integer :num_of_trans

      t.timestamps
    end
  end
end
