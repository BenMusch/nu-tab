# frozen_string_literal: true
class SchoolsController < ApplicationController
  def index
    @schools = School.order(:name).map(&:as_json)
  end

  def show
    @school = School.find(params[:id]).as_json
  end
end
