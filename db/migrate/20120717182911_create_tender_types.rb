class CreateTenderTypes < ActiveRecord::Migration
  def change
    create_table :tender_types do |t|
      t.string :name
      t.text :info
      t.boolean :is_iteration, default:false
      t.boolean :is_selling, default:true

      t.timestamps
    end
  end
end
