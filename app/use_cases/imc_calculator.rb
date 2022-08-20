# frozen_string_literal: true

class ImcCalculator
  def initialize(imc_params)
    @height = imc_params['height']
    @weight = imc_params['weight']
  end

  def call
    set_imc
    set_classification
    set_obesity
    mount_result
  end

  private

  attr_reader :height, :weight, :imc

  def set_imc
    @imc = (weight / height**2).ceil(1)
  end

  def set_classification
    @classification =
      case imc
      when 0..16.49 then 'Peso severamente abaixo do normal'
      when 16.5..18.49 then 'Peso abaixo do normal'
      when 18.5..24.99 then 'Normal'
      when 25..29.99 then 'Sobrepeso'
      when 30..34.99 then 'Sobrepeso'
      when 35..Float::INFINITY then 'Sobrepeso'
      end
  end

  def set_obesity
    @obesity =
      case imc
      when 25..29.99 then 'I'
      when 30..34.99 then 'II'
      when 35..Float::INFINITY then 'III'
      else 'Não obeso'
      end
  end

  def mount_result
    { classification: @classification, obesity: @obesity }
  end
end
