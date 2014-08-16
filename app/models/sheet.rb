class Sheet < ActiveRecord::Base
  def convert
    return unless original_code

    sass_code = Sass::Engine.new(
      original_code,
      syntax: :scss,
      style: :compact
    )
    self.converted_code = sass_code.render
  end

  def detect_convert_type(convert_type_1)
    self.converted_type = convert_type_1 ? 1 : 2
  end
end
