module ApplicationHelper
  def title
    if @title
      "#{@title} - NU Tab"
    else
      'NU Tab'
    end
  end

  def body_class
    'app'
  end
end
