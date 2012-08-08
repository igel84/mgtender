#encoding: utf-8
class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name
      t.text :body

      t.timestamps
    end

    s = Setting.new(name: 'company', body: 'информация о компании')
    s.save
  end

end
