class CreateTenderIterations < ActiveRecord::Migration
  def change
    create_table :tender_iterations do |t|
      t.integer :tender_id
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :is_ended, default: false

      t.timestamps
    end
  end
end
