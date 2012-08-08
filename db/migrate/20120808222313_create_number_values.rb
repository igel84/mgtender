class CreateNumberValues < ActiveRecord::Migration
  def change
    create_table :number_values do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end

    NumberValue.create(name: 'attach', count: 10)
  end
end
