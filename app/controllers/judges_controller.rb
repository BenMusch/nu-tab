class JudgesController < ApplicationController
  before_action :set_judge, only: [:show, :edit, :update, :destroy]

  # GET /judges
  def index
    @judges = Judge.all
  end

  # GET /judges/1
  def show
  end

  # GET /judges/new
  def new
    @judge = Judge.new
  end

  # GET /judges/1/edit
  def edit
  end

  # POST /judges
  def create
    @judge = Judge.new(judge_params)

    if @judge.save
      redirect_to @judge, notice: 'Judge was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /judges/1
  def update
    if @judge.update(judge_params)
      redirect_to @judge, notice: 'Judge was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /judges/1
  def destroy
    @judge.destroy
    redirect_to judges_url, notice: 'Judge was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_judge
      @judge = Judge.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def judge_params
      params.fetch(:judge, {})
    end
end
