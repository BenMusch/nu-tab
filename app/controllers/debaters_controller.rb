# frozen_string_literal: true
class DebatersController < ApplicationController
  before_action :set_debater, only: [:show, :edit, :update, :destroy]

  # GET /debaters
  def index
    @debaters = Debater.all
  end

  # GET /debaters/1
  def show
  end

  # GET /debaters/new
  def new
    @debater = Debater.new
  end

  # GET /debaters/1/edit
  def edit
  end

  # POST /debaters
  def create
    @debater = Debater.new(debater_params)

    if @debater.save
      redirect_to @debater, notice: 'Debater was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /debaters/1
  def update
    if @debater.update(debater_params)
      redirect_to @debater, notice: 'Debater was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /debaters/1
  def destroy
    @debater.destroy
    redirect_to debaters_url, notice: 'Debater was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_debater
    @debater = Debater.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def debater_params
    params.require(:debater).permit(:novice, :name, :school_id, :team_id)
  end
end
