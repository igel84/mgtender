class CreateSpheres < ActiveRecord::Migration
  def change
    create_table :spheres do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end
  end
end
