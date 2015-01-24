module ApplicationHelper

  def page(*pages)
    pages.each do |page|
      return true if page == request.env['PATH_INFO']
    end
    false
  end

end
