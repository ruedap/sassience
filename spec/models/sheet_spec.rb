require 'rails_helper'

RSpec.describe Sheet, type: :model do

  describe '.convert' do
    it 'converts the original code' do
      params = {}
      params[:original_code] = '.hoge{width:100%;height:30px}'
      sheet = Sheet.new(params)
      sheet.convert

      expect(sheet.converted_code).to eq(".hoge { width: 100%; height: 30px; }\n")
    end
  end

end
