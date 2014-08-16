require 'rails_helper'

RSpec.describe Sheet, type: :model do

  describe '.convert' do
    context 'when `original_code` is empty' do
      it 'does not convert the original code' do
        params = {}
        sheet = Sheet.new(params)
        sheet.convert

        expect(sheet.converted_code).to be_nil
      end
    end

    context 'when `original_code` is not empty' do
      it 'converts the original code' do
        params = {}
        params[:original_code] = '.hoge{width:100%;height:30px}'
        sheet = Sheet.new(params)
        sheet.convert

        expect(sheet.converted_code).to eq(".hoge { width: 100%; height: 30px; }\n")
      end
    end
  end

  describe '.detect_convert_type' do
    context 'when argument is nil' do
      it 'returns 2' do
        sheet = Sheet.new
        expect(sheet.detect_convert_type(nil)).to eq(2)
      end
    end

    context 'when argument is not nil' do
      it 'returns 1' do
        sheet = Sheet.new
        expect(sheet.detect_convert_type('')).to eq(1)
      end
    end
  end

end
