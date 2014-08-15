class Sheet < ActiveRecord::Base

  def convert
    sass_code = Sass::Engine.new(
      original_code,
      syntax: :scss,
      style: :compact
    )
    self.converted_code = sass_code.render
  end

end
