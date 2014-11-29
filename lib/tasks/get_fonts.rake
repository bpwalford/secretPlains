require 'open-uri'

task :get_fonts do

  # parse wiki and put fonts in list
  # ****************************************************************************
  puts "parsing wiki page to generate font list"
  puts "..."

  doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/List_of_typefaces"))
  fontHtml = doc.css("div.div-col.columns.column-width ul li a")

  fontHtml.flat_map do |font|

    font = font.to_s

    font[0] = ""
    font[-1] = ""

    font = font.split("<")
    font = font.first

    font = font.split(">")
    font = font.last

    fonts = font.split("/")
    fonts.flat_map! do |font|
      if font.include?("(")
        font, alternate = font.split("(")
        [font, alternate[0..-2]]
      else
        [font]
      end
    end

    fonts.reject! do |font|
      font.include?("a href=\"")
    end
    fonts.map(&:strip)
  end

  11.times do
    fonts.pop
  end

  puts "finished"
  puts "collected #{fonts.length} new fonts"
  # ****************************************************************************

  # compare list of fonts to penopticlick fonts
  # ****************************************************************************
  pen_fonts = ["Al Bayan","Al Nile","Al Tarikh","American Typewriter","Andale Mono","Apple Braille","Apple Chancery","Apple Color Emoji","Apple SD Gothic Neo","Apple Symbols","AppleGothic","AppleMyungjo","Arial","Arial Black","Arial Hebrew","Arial Hebrew Scholar","Arial Narrow","Arial Rounded MT Bold","Arial Unicode MS","Athelas","Avenir","Avenir Next","Avenir Next Condensed",
  "Ayuthaya","Baghdad","Bangla MN","Bangla Sangam MN","Baoli SC","Baskerville","Beirut","Big Caslon","Bodoni 72","Bodoni 72 Oldstyle","Bodoni 72 Smallcaps","Bodoni Ornaments","Bradley Hand","Brush Script MT","Chalkboard","Chalkboard SE","Chalkduster","Charter","Cochin","Comic Sans MS","Copperplate","Corsiva Hebrew","Courier","Courier New","Damascus",
  "DecoType Naskh","Devanagari MT","Devanagari Sangam MN","Didot","DIN Alternate","DIN Condensed","Diwan Kufi","Diwan Thuluth","Euphemia UCAS","Farah","Farisi","Futura","GB18030 Bitmap","Geeza Pro","Geneva","Georgia","Gill Sans","Gujarati MT","Gujarati Sangam MN","GungSeo","Gurmukhi MN","Gurmukhi MT","Gurmukhi Sangam MN","Hannotate SC","Hannotate TC",
  "HanziPen SC","HanziPen TC","HeadLineA","Heiti SC","Heiti TC","Helvetica","Helvetica Neue","Herculanum","Hiragino Kaku Gothic Pro","Hiragino Kaku Gothic ProN","Hiragino Kaku Gothic Std","Hiragino Kaku Gothic StdN","Hiragino Maru Gothic Pro","Hiragino Maru Gothic ProN","Hiragino Mincho Pro","Hiragino Mincho ProN","Hiragino Sans GB","Hoefler Text","Impact","InaiMathi","Iowan Old Style","ITF Devanagari","Kailasa","Kaiti SC","Kaiti TC",
  "Kannada MN","Kannada Sangam MN","Kefa","Khmer MN","Khmer Sangam MN","Kohinoor Devanagari","Kokonor","Krungthep","KufiStandardGK","Lantinghei SC","Lantinghei TC","Lao MN","Lao Sangam MN","Libian SC","LiHei Pro","LiSong Pro","Lucida Grande","Luminari","Malayalam MN","Malayalam Sangam MN","Marion","Marker Felt","Menlo","Microsoft Sans Serif","Mishafi",
  "Mishafi Gold","Monaco","Mshtakan","Muna","Myanmar MN","Myanmar Sangam MN","Nadeem","Nanum Brush Script","Nanum Gothic","Nanum Myeongjo","Nanum Pen Script","New Peninim MT","Noteworthy","Optima","Oriya MN","Oriya Sangam MN","Osaka","Palatino","Papyrus","PCMyungjo","Phosphate","PilGi","Plantagenet Cherokee","PT Mono","PT Sans",
  "PT Sans Caption","PT Sans Narrow","PT Serif","PT Serif Caption","Raanana","Sana","Sathu","Savoye LET","Seravek","Shree Devanagari 714","SignPainter","Silom","Sinhala MN","Sinhala Sangam MN","Skia","Snell Roundhand","Songti SC","Songti TC","STFangsong","STHeiti","STIXGeneral","STIXIntegralsD","STIXIntegralsSm","STIXIntegralsUp","STIXIntegralsUpD",
  "STIXIntegralsUpSm","STIXNonUnicode","STIXSizeFiveSym","STIXSizeFourSym","STIXSizeOneSym","STIXSizeThreeSym","STIXSizeTwoSym","STIXVariants","STKaiti","STSong","Sukhumvit Set","Superclarendon","Symbol","Tahoma","Tamil MN","Tamil Sangam MN","Telugu MN","Telugu Sangam MN","Thonburi","Times","Times New Roman","Trattatello","Trebuchet MS","Verdana","Waseem",
  "Wawati SC","Wawati TC","Webdings","Weibei SC","Weibei TC","Wingdings","Wingdings 2","Wingdings 3","Xingkai SC","Yuanti SC","YuGothic","YuMincho","Yuppy SC","Yuppy TC","Zapf Dingbats","Zapfino"]

  puts "penopticlick fonts contains #{pen_fonts.length} fonts"
  puts "comparing with wiki fonts"
  puts "..."

  fonts_added = 0
  fonts_final = Array.new

  pen_fonts.each do |font|
    if fonts.include?(font)
      next
    else
      fonts << font
      fonts_added += 1
      puts "adding #{font} to font list"
      puts "-"
    end
  end

  puts "..."
  puts "finished comparing fonts"
  puts "added #{fonts_added} fonts to fonts list"
  puts "total number of fonts is now #{fonts.length}"
  # ****************************************************************************

  # format font list to write to seed file
  # ****************************************************************************
  fonts.delete(nil)

  fonts.each do |font|
    font.strip!
  end

  puts "writing array of fonts to seeds.rb"

  File.open("seeds.rb", 'w') { |file| file.write(fonts)}

  puts "finished "
  # ****************************************************************************

end
