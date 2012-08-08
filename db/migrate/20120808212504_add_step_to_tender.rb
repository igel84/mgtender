class AddStepToTender < ActiveRecord::Migration
  def change
    add_column :tenders, :wicked, :string, default: 'start'
  end
end
