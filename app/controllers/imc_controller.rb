class ImcController < ApplicationController
  before_action :set_imc, only: [:show, :update, :destroy]

  def index
    @imc = Imc.all

    render json: @imc
  end

  def show
    render json: @imc
  end

  def create
    @imc = Imc.new(imc_params)

    if @imc.save
      render json: @imc, status: :created, location: @api_imc
    else
      render json: @imc.errors, status: :unprocessable_entity
    end
  end

  def update
    if @imc.update(imc_params)
      render json: @imc
    else
      render json: @imc.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @imc.destroy
  end

  private

  def set_imc
    @imc = Imc.find(params[:id])
  end

  def imc_params
    params.require(:imc).permit(:height, :weight)
  end
end