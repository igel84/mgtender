class CreateWinners < ActiveRecord::Migration
  def change
    create_table :winners, id: false do |t|
      t.integer :tender_id
      t.integer :propose_id

      t.timestamps
    end
  end
end
