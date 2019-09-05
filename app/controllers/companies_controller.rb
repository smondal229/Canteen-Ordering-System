class CompaniesController < ApplicationController
  
  before_action :authenticate_admin
  before_action :set_company, only: [:edit, :update, :destroy]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    
    if @company.save
      redirect_to(companies_path, flash: { success: "New company added" })
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to(companies_path, flash: { success: "Company information updated" })
    else
      render "edit"
    end
  end

  def destroy
    @company.destroy
    redirect_to(companies_path, flash: { info: "#{@company} data deleted" })
  end

  private
    def company_params
      params.require(:company).permit(:name)
    end

    def set_company
      @company = Company.find(params[:id])
    end
    
end
