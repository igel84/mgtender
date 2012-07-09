class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :html_content

      t.timestamps
    end
  end
end
