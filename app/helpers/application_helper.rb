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

  def link_or_none(model, method: :name)
    model ? link_to(model.send(method), model) : 'None'
  end
end
