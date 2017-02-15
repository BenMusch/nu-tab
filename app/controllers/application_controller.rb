# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    render text: 'Hello world'
  end
end
