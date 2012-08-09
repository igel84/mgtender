#encoding: utf-8
class Excel < ActiveRecord::Base
  attr_accessible :name, :content_type, :data, :user_id#, :uploaded_file

  #belongs_to :user

  def uploaded_file=(field)
    self.name = base_part_of(field.original_filename)
    self.content_type = field.content_type.chomp
    self.data = field.read
  end

  #def base_part_of(file_name)
  #  File.basename(file_name).gsub(/[^\w._-]/, '')
  #end
end