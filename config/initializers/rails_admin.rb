#encoding: utf-8
RailsAdmin.config do |config|
  
  #config.authenticate_with do
    # Use sorcery's before filter to auth users
  #  require_login
    
    #unless logged_in?
    #  session[:return_to] = request.url
    #  redirect_to login_url, :alert => "You must first log in or sign up before accessing this page."
    #end
  #end
  
  I18n.default_locale = :ru
  config.current_user_method { current_user }
  
  config.authorize_with{
    redirect_to main_app.root_path, :alert => "Вы не обладаете достаточными правами для доступа к данной странице" unless current_user.role? :admin
  }
  #config.authorize_with :cancan  

  #config.audit_with :history, User
  config.main_app_name = ['a1', 'Admin']
  config.default_items_per_page = 50
  config.excluded_models = [Ckeditor::Asset, Ckeditor::AttachmentFile, Ckeditor::Picture, GritterNotice]
  config.label_methods << [:id, :name, :title]
  config.model News do
    # Found associations:
      configure :id, :integer       
      configure :html_content, :text       
      #configure :created_at, :datetime 
      #configure :updated_at, :datetime 
      #configure :special_offer, :boolean 
      #configure :meta_title, :string 
      #configure :help_info, :boolean   #   # Sections:
    list do; end
    export do; end
    show do; end
    edit do
      #field :parent_id, :integer do
      #  visible false
      #end
      #field :parent, :belongs_to_association
      field :html_content, :text do
        ckeditor do 
          true
        end
      end
    end
    create do; end
    update do; end
  end
end
