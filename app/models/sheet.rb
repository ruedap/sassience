class Sheet < ActiveRecord::Base
  def convert
    base_code = original_code ? original_code : example_code

    sass_code = Sass::Engine.new(
      base_code,
      syntax: :scss,
      style: converted_type_name
    )

    rend_code = sass_code.render
    rend_code = remove_blank_line(rend_code) if converted_type_name == :compact
    self.converted_code = rend_code
  end

  def converted_type_name
    converted_type == 1 ? :expanded : :compact
  end

  def detect_convert_type(convert_type_1)
    self.converted_type = convert_type_1 ? 1 : 2
  end

  def remove_blank_line(code)
    result, backward, middle, forward = '', '', '', ''
    css_regexp   = /\s\{\s.*\s\}\s/
    empty_regexp = /^$/

    code.each_line do |line|
      backward = middle
      middle   = forward
      forward  = line
      next if backward =~ css_regexp && middle =~ empty_regexp && forward =~ css_regexp
      result += middle
    end
    result += forward
    result
  end

  def example_code
    <<-EOS
@charset "UTF-8";
/* =================================================================================
/* 【注意】このCSSは変換結果の確認用サンプルです。
/* ================================================================================= */
/* ---------------------------------------------------------------------------------
/* ページ下部の2つのタイプ（ボタン）を押し比べて、ネストの変化をご確認ください。
/* --------------------------------------------------------------------------------- */
body { width: 900px; margin: 0 auto; color: #382c03; background-color: #f6ea8d; }
h1 a { background-repeat: no-repeat; display: block; width: 315px; height: 90px; text-indent: -9999px; }
table { border-collapse: collapse; border-spacing: 0; }
ol, ul { list-style: none; }
code, pre { font-family: monospace; line-height: 100%; }

/* wrapper */
#wrap { width: 900px; margin: 0 auto; }
#head-wrapper { width: 860px; margin: 30px auto 25px; }
#logo-wrapper { width: 315px; }
#caption-wrapper { width: 450px; }

/* footer */
hr { border-width: 3px 0px 0px 0px; border-style: solid; border-color: #c00230; height: 3px; width: 860px; }
#footer { width: 748px; margin: 7px auto 30px; }

/* ---------------------------------------------------------------------------------
/* このサービスの利用により生じたいかなる障害・トラブルに対しても
/* SASSIENCEでは責任を持てませんので、利用者の責任の上でご利用ください。
/* --------------------------------------------------------------------------------- */
    EOS
  end
end
