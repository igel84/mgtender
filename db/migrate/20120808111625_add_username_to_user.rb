class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string

    User.all.each do |user|
      user.username = user.email
      user.save
    end
    
  end
end
