module ApplicationHelper

  def page(*pages)
    pages.each do |page|
      return true if page == request.env['PATH_INFO']
    end
    false
  end

  def matched(property)
    if property
      return content_tag(:span, ' matched', class: 'match')
    else
      return content_tag(:span, ' not matched', class: 'no-match')
    end
  end

  def make_text(length)
    words = ['Lorem','ipsum','dolor','sit','amet','eum','cibo','nobis','definitiones','cu','pri','ex','nusquam','senserit','gloriatur','ad','his','nostrum','omittam','laboramus','In','idque','temporibus','delicatissimi','nam','ne','iusto','comprehensam','vel','paulo','fuisset','volutpat','ne','mea','At','semper','appellantur','sea','Autem','quodsi','intellegam','has']

    text = ''
    length.times do
      text += "#{words.sample} "
    end

    text.capitalize
  end

  def format_array(array)
    return content_tag(:em, '. . .') if array.length == 0

    array = array.to_s
    array = array.gsub('"', '')
    array[0] = ''
    array[-1] = ''
    return content_tag(:span, array)
  end

  def format_fonts(font_array)
    return content_tag(:em, '. . .') if font_array.length == 0

    font_string = ''
    font_array.each{|f| font_string += "#{f} "}
    return content_tag(:span, font_string)
  end

end
