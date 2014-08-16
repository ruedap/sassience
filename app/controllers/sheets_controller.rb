class SheetsController < ApplicationController
  # GET /sheets/new
  def new
    @sheet = Sheet.new
    @converted_sheet = converted_sheet
    @sheet.original_code = @converted_sheet.converted_code if @converted_sheet
  end

  # POST /sheets
  def create
    @sheet = Sheet.new(sheet_params)
    @sheet.detect_convert_type(params[:convert_type_1])
    @sheet.convert

    if @sheet.save
      session[:converted_sheet_id] = @sheet.id
      redirect_to root_path
    else
      render :new
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def sheet_params
    params.require(:sheet).permit(
      :original_code,
      :convert_type_1,
      :convert_type_2
    )
  end

  def converted_sheet
    sheet_id = session[:converted_sheet_id]
    session[:converted_sheet_id] = nil
    sheet_id ? Sheet.find(sheet_id) : nil
  end
end
