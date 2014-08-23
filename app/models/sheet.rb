class Sheet < ActiveRecord::Base
  def convert
    original_code = example_code unless original_code

    sass_code = Sass::Engine.new(
      original_code,
      syntax: :scss,
      style: converted_type_name
    )
    self.converted_code = sass_code.render
  end

  def converted_type_name
    converted_type == 1 ? :expanded : :compact
  end

  def detect_convert_type(convert_type_1)
    self.converted_type = convert_type_1 ? 1 : 2
  end

  private

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


/* =================================================================================
/* 【ご利用上の注意点】以下の点にお気をつけて、SASSIENCEをご利用ください。
/* ================================================================================= */
/* ---------------------------------------------------------------------------------
/* @charset指定はUTF-8のみ対応で、それ以外の文字コード指定は変換に失敗します。
/* また、日本語等が含まれていて、@charset指定がない場合は、UTF-8が自動指定されます。
/* --------------------------------------------------------------------------------- */
/* ---------------------------------------------------------------------------------
/* !important指定は、セミコロンの後に指定すると変換に失敗します。
/* プロパティに続けて半角スペースで区切って記述し、その後にセミコロンを付けます。
/* --------------------------------------------------------------------------------- */
.important_sample { color: #000000 !important; margin-right: 10px; margin-left: 5px !important; }


/* ---------------------------------------------------------------------------------
/* filter: invert(); は変換に失敗することを確認しています。
/* --------------------------------------------------------------------------------- */
/* ---------------------------------------------------------------------------------
/* このサービスの利用により生じたいかなる障害・トラブルに対しても
/* SASSIENCEでは責任を持てませんので、利用者の責任の上でご利用ください。
/* --------------------------------------------------------------------------------- */
    EOS
  end
end
