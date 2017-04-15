# frozen_string_literal: true
class DebatersController < ApplicationController
  def index
    @debaters = Debater.all.order(:name).map(&:as_json)
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @debaters }
    end
  end

  def create
    @debater = Debater.new(debater_params)
    if @debater.save
      render json: @debater
    else
      render json: @debater.errors, status: :unprocessable
    end
  end

  def show
    @debater = Debater.find(params[:id]).as_json(include: :school)
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @debater }
    end
  end

  def update
    @debater = Debater.find(params[:id])
    if @debater.update(debater_params)
      render json: @debater
    else
      render json: @debater.errors, status: :unprocessable
    end
  end

  def destroy
    @debater = Debater.find(params[:id])
    if @debater.destroy
      render json: {}, status: 200
    else
      render json: {}, status: :unprocessable
    end
  end

  private

  def debater_params
    params.require(:debater).permit(:school, :novice)
  end
end
