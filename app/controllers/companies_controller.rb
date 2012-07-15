#encoding: utf-8
class CompaniesController < ApplicationController
	skip_before_filter :require_login, :only => []

	def edit
  	@company = Company.find(current_user.company_id)
  end

  def create    
  end

  def update
    #params[:user].delete :company if params[:user][:company]
    #params[:user].delete :company_id if params[:user][:company_id]

    @company = Company.find(params[:id])
    #params[:user][:company_id] = @user.company_id

    if @company.update_attributes(params[:company])
      redirect_to company_path, notice: "Изменения успешно сохранены!"
    else
      render :edit
    end
  end

  def logo_delete
    @company = Company.find(params[:id])
    @company.logo.clear
    @company.save
    redirect_to company_path, notice: "Логотип удален!"
  end
  
end