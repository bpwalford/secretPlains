task :get_fonts do

  require 'open-uri'
  doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/List_of_typefaces"))

  # fonts = doc.css('div#content div#bodyContent div#mw-content-text ul li a')
  fonts = doc.css("div.div-col.columns.column-width ul li a")
  # fonts = doc.css("mw-body mw-body-content mw-content-ltr div-col columns column-width ul li")

  fonts.each do |font|

    font = font.to_s

    chars = font.split("")

    chars[0] = ""
    chars[chars.length + 1] = ""

    break_point = chars.index(">")
    break_point2 = chars.index("<")

    chars = chars[0..break_point2-1]
    chars = chars.join
    chars = chars.split(">")
    chars = chars.pop
    font = chars

    puts font

  end

  puts fonts.length
  puts "done"

end
