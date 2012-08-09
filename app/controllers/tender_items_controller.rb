#encoding: utf-8
class TenderItemsController < ApplicationController
  before_filter :current_tender #, except: [:new]

  def create
    #@tender.tender_items << TenderItem.new(params[:tender_item])
    #name = params[:upload][:file].original_filename
    
    #data = params[:upload][:file].to_file
    #@workbook = Spreadsheet.open(data)
    #@excel = Excel.new(params[:excel]) if params[:excel]
    
    #if params[:excel]
      #@excel = Excel.new(uploaded_file: params[:excel][:uploaded_file])
      #@excel.uploaded_file = params[:excel][:uploaded_file]
      #@excel.user = current_user
      #@excel.save
    #end
    #if params[:excel][:uploaded_file].original_filename =~ /.*.xls$/i
        #upload = params[:excel][:uploaded_file]
        #content = upload.open #upload.is_a?(StringIO) ? upload.read : File.read(upload.tempfile)
        #oo = Excel.new(content)
        #rooparse(oo)        
    #end

    require 'fileutils'
    require 'iconv'
    require 'roo'
     
    tmp = params[:excel][:uploaded_file].tempfile
    file = File.join("public", "#{(0...50).map{ ('a'..'z').to_a[rand(26)] }.join}.xls")
    FileUtils.cp tmp.path, file
     
    oo = Excel.new(file)
    oo.default_sheet = oo.sheets.first
    2.upto(5) do |line|
      name = oo.cell(line,'A')
      count = oo.cell(line,'B')
      price = oo.cell(line,'C')

      @tender.tender_items << TenderItem.new(name: name, count: count, price: price) if !name.blank? && !count.blank? && !price.blank?
    end
    #rooparse(oo)
    FileUtils.rm file

    #file = Spreadsheet::Excel::Workbook.new(params[:excel][:uploaded_file].original_filename, 'w+')
    #file.write(params[:excel][:uploaded_file][:tempfile].read )

    @tender.save
    
    redirect_to tender_tender_items_path(tender_id: @tender.id)
  end

  def destroy
    TenderItem.find(params[:id]).destroy
    redirect_to tender_tender_items_path(tender_id: @tender.id)
  end

  private
    def current_tender
      @tender = Tender.find(params[:tender_id])         
    end
end
