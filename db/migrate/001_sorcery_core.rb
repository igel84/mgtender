class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email,            :default => nil # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.boolean :admin,           :default => false

      t.integer :company_id
      
      t.string :name
      t.string :phone
      t.string :fname
      t.string :nname
      t.string :photo_file_name      
      t.string :photo_content_type
      t.datetime :photo_updated_at
      t.integer :photo_file_size

      t.boolean :accept_company,  default: false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end