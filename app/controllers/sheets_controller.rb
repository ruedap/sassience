class SheetsController < ApplicationController
  # GET /sheets/new
  def new
    @sheet = Sheet.new
  end

  # POST /sheets
  def create
    @sheet = Sheet.new(sheet_params)

    respond_to do |format|
      if @sheet.save
        format.html { redirect_to root_path, notice: 'Sheet was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def sheet_params
    params.require(:sheet).permit(:original_code)
  end
end
