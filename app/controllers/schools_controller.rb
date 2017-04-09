class SchoolsController < ApplicationController
  def index
    @schools = School.order(:name).to_a
    @schools = @schools.map { |school| json_for(school) }
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @schools }
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
  end

  def destroy
  end

  private

  def json_for(school)
    school.as_json.merge(show_path: school_path(school))
  end
end
