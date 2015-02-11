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
  
end
