class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :full_name
      t.string :inn
      t.integer :owner_form_id
      t.integer :sphere_id
      t.string :general_phone
      t.string :logo_content_type
      t.integer :logo_file_size
      t.boolean :is_nds, default: false

      t.timestamps
    end
  end
end
