# frozen_string_literal: true

class ImcCalculator
  def initialize(imc_params)
    @height = imc_params['height']&.to_f
    @weight = imc_params['weight']&.to_f
  end

  def call
    set_imc
    set_classification
    set_obesity
    result
  end

  private

  attr_reader :height, :weight, :imc, :classification, :obesity

  def set_imc
    @imc = (weight / height**2).ceil(1)
  end

  def set_classification
    @classification =
      case imc
      when 0..16.49 then 'Peso severamente abaixo do normal'
      when 16.5..18.49 then 'Peso abaixo do normal'
      when 18.5..24.99 then 'Normal'
      when 25.. then 'Sobrepeso'
      end
  end

  def set_obesity
    @obesity =
      case imc
      when 25..29.99 then 'I'
      when 30..34.99 then 'II'
      when 35.. then 'III'
      else 'Não obeso'
      end
  end

  def result
    { imc: imc, classification: classification, obesity: obesity }
  end
end
