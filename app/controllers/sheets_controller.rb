class SheetsController < ApplicationController
  # GET /sheets/new
  def new
    @sheet = Sheet.new
    @converted_sheet = converted_sheet
    @conversion_error = conversion_error
    @sheet.original_code = @converted_sheet.converted_code if @converted_sheet
  end

  # POST /sheets
  def create
    @sheet = Sheet.new(sheet_params)
    @sheet.detect_convert_type(params[:convert_type_1])

    begin
      @sheet.convert
    rescue Sass::SyntaxError => e
      error_line = e.backtrace.first.scan(/[0-9]+/).last
      error_line_num = error_line ? error_line.scan(/./) : nil
      error_type = error_line ? 1 : 0
      session[:conversion_error] = { type: error_type, line_num: error_line_num }
    rescue
      session[:conversion_error] = { type: 0 }
    end

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

  def conversion_error
    error_obj = session[:conversion_error]
    session[:conversion_error] = nil
    error_obj
  end
end
