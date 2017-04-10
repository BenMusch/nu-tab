# frozen_string_literal: true
class SchoolsController < ApplicationController
  def index
    @schools = School.order(:name).to_a
    @schools = @schools.map { |school| json_for(school) }
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @schools }
    end
  end

  def create
    @school = School.new(school_params)
    if @school.save
      render json: json_for(@school)
    else
      render json: @school.errors, status: :unprocessable
    end
  end

  def show
    @school = json_for(School.find(params[:id]))
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @school }
    end
  end

  def update
    @school = School.find(params[:id])
    if @school.update(school_params)
      render json: json_for(@school)
    else
      render json: @school.errors, status: :unprocessable
    end
  end

  def destroy
    @school = School.find(params[:id])
    if @school.destroy!
      render json: {}, status: 200
    else
      render json: {}, status: :unprocessable
    end
  end

  private

  def school_params
    params.require(:school).permit(:name)
  end

  def json_for(school)
    school.as_json.merge(show_path: school_path(school))
  end
end
