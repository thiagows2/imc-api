# frozen_string_literal: true

class ImcController < ApplicationController
  def calculate_imc
    result = ImcCalculator.new(imc_params).call

    render json: result
  end

  private

  def imc_params
    params.require(:imc).permit(:height, :weight)
  end
end
