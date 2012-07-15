class CreateOwnerForms < ActiveRecord::Migration
  def change
    create_table :owner_forms do |t|
      t.string :name
      t.boolean :is_nds, default: false

      t.timestamps
    end
  end
end
