#encoding: utf-8
class UsersController < ApplicationController
	skip_before_filter :require_login, :only => [:new, :create, :activate]

	def activate
	  if (@user = User.load_from_activation_token(params[:id]))
	    @user.activate!
	    redirect_to(login_path, :notice => 'Пользователь успешно ативирован')
	  else
	    not_authenticated
	  end
	end

	def new
    @user = User.new
    @company = Company.new
  end

  def create
    @user = User.new(
      email: params[:user][:email], 
      password: params[:user][:password], 
      password_confirmation: params[:user][:password_confirmation], 
      name: params[:user][:name], 
      fname: params[:user][:fname], 
      nname: params[:user][:nname], 
      phone: params[:user][:phone],
      company_id: params[:user][:company_id],
      category_ids: params[:user][:category_ids],
      photo: params[:user][:photo]) #, :photo #params[:user])
    
    @company = Company.new(params[:user][:company])

    flash.now[:user_error] = 'Необходимо корректно заполнить все поля (необязательное лишь "аватар")' unless @user.valid?
    flash.now[:company_error] = 'Выберите компанию из списка, либо зарегистрируйте новую (необходимо будет заполнить все поля компании)' unless (@company.valid? || params[:user][:company_id])

    if @user.valid? && (@company.valid? || params[:user][:company_id])
      @user.save
      #@user.reload
      #@user.company_id = 6 #Company.find(params[:user][:company_id]) if params[:user][:company_id]
      #@user.save
      
      unless params[:user][:company_id]
        @company.master_id = @user.id
        @company.save
        @user.update_attribute(:company_id, @company.id)
        @user.save
        
      end
      redirect_to root_url, :notice => "Пользователь успешно зарегистрирован! Для активации учетной записи перейдите по ссылке в письме, отправленном на ваш email"        
    else
      flash.now[:pass_error] = @user.errors[:password].join(", ") if @user.errors[:password].any?
      flash.now[:file_error] = @user.errors[:photo].join(", ") if @user.errors[:photo].any?
      flash.now[:company_inn_error] = @company.errors[:inn].join(",") if @company.errors[:inn].any?

      @user.company_id = params[:user][:company_id] if params[:user][:company_id]
      render :new
    end
  end

  def edit
  	@user = current_user
  end

  def update
    params[:user].delete :company if params[:user][:company]
    params[:user].delete :company_id if params[:user][:company_id]

    #params[:user].delete :password if params[:user][:password].blank?
    #params[:user].delete :password_confirmation if params[:user][:password_confirmation].blank?

    @user = User.find(params[:id])
    params[:user][:company_id] = @user.company_id

    if @user.update_attributes(params[:user])
      redirect_to profile_path, notice: "Изменения успешно сохранены!"
    else
      flash.now[:user_error] = 'Необходимо корректно заполнить все поля, необязательные поля: "аватар", "пароль и его подтврерждение"' unless @user.valid?
      flash.now[:pass_error] = @user.errors[:password].join(", ") if @user.errors[:password].any?
      flash.now[:file_error] = @user.errors[:photo].join(", ") if @user.errors[:photo].any?
      render :edit
    end
  end

  def photo_delete
    @user = User.find(params[:id])
    @user.photo.clear
    @user.save
    redirect_to profile_path, notice: "Фото удалено!"
  end
  
end