class ScratchesController < ApplicationController
  before_action :set_scratch, only: [:show, :edit, :update, :destroy]

  # GET /scratches
  def index
    @scratches = Scratch.all
  end

  # GET /scratches/1
  def show
  end

  # GET /scratches/new
  def new
    @scratch = Scratch.new
  end

  # GET /scratches/1/edit
  def edit
  end

  # POST /scratches
  def create
    @scratch = Scratch.new(scratch_params)

    if @scratch.save
      redirect_to @scratch, notice: 'Scratch was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /scratches/1
  def update
    if @scratch.update(scratch_params)
      redirect_to @scratch, notice: 'Scratch was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /scratches/1
  def destroy
    @scratch.destroy
    redirect_to scratches_url, notice: 'Scratch was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scratch
      @scratch = Scratch.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def scratch_params
      params.require(:scratch).permit(:team_id_id, :debater_id_id, :type)
    end
end
