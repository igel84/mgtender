class CreateTenderRequests < ActiveRecord::Migration
  def change
    create_table :tender_requests do |t|
      t.integer :tender_id
      t.integer :user_id
      t.boolean :accepted_t, default: false
      t.boolean :accepted_p, default: false
      t.string  :company_name
      t.string  :company_email

      t.timestamps
    end
  end
end
