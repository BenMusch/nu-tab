class ScratchesController < ApplicationController
  before_action :set_scratch, only: [:show, :destroy]

  # GET /scratches
  def index
    if params[:judge_id]
      @entity = Judge.find(params[:judge_id])
      @scratches = Scratch.where(judge_id: params[:judge_id])
    elsif params[:team_id]
      @entity = Team.find(params[:team_id])
      @scratches = Scratch.where(team_id: params[:team_id])
    end
  end

  # GET /scratches/1
  def show
  end

  # GET /scratches/new
  def new
    @scratch = Scratch.new
    @scratch.team_id = params[:team_id]
    @scratch.judge_id = params[:judge_id]
  end

  # GET /scratches/1/edit
  def edit
  end

  # POST /scratches
  def create
    @scratch = Scratch.new(scratch_params)

    if @scratch.save
      redirect_to :back, fallback_location: root_path, notice: 'Scratch was successfully created.'
    else
      render :new
    end
  end

  # DELETE /scratches/1
  def destroy
    @scratch.destroy
    redirect_to :back, fallback_location: root_path, notice: 'Scratch was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_scratch
    @scratch = Scratch.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def scratch_params
    params.require(:scratch).permit(:team_id, :judge_id, :scratch_type).tap do |p|
      p[:scratch_type] = p[:scratch_type].to_i if p[:scratch_type]
    end
  end
end
