class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :inn
      t.integer :owner_form_id
      t.integer :sphere_id
      t.string :general_phone
      
      t.string :logo_content_type
      t.integer :logo_file_size
      t.string :logo_file_name      
      t.datetime :logo_updated_at
      
      t.boolean :is_nds, default: false
      t.integer :master_id

      t.timestamps
    end
  end
end
