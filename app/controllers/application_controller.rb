# frozen_string_literal: true
class ApplicationController < ActionController::Base
  def index
    @schools = School.order(:name)
    @judges = Judge.order(:name)
    @teams = Team.order(:name)
    @debaters = Debater.order(:name)
    @rooms = Room.order(:name)
    render 'shared/dashboard'
  end
end
