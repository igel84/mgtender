class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :fname, :nname, :phone, :company_id

  has_attached_file :photo, :styles => {
  	:thumb=> ["180x120", :jpg], :normal => ["600x600>", :jpg]
  }

  # attr_accessible :title, :body

  belongs_to :company
  attr_accessible :company
  attr_writer :company
end