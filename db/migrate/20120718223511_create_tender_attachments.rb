class CreateTenderAttachments < ActiveRecord::Migration
  def change
    create_table :tender_attachments do |t|
      t.integer :tender_id
      t.string :attach_file_name
      t.string :attach_content_type
      t.datetime :attach_updated_at
      t.integer :attach_file_size

      t.timestamps
    end
  end
end
