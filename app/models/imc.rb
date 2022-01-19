class Imc < ApplicationRecord
  validates :height, :weight, presence: true, numericality: { greater_than: 0 } 

  before_save :imc_calculator

  private

  def imc_calculator
    self.imc = (weight / height ** 2).ceil(1)

    define_classification
    define_obesity
  end

  def define_classification
    self.classification =
      case imc
      when 0..16.49 then 'Peso severamente abaixo do normal'
      when 16.5..18.49 then 'Peso abaixo do normal'
      when 18.5..24.99 then 'Normal'
      when 25..29.99 then 'Sobrepeso'
      when 30..34.99 then 'Sobrepeso'
      when 35..Float::INFINITY then 'Sobrepeso'
      end
  end

  def define_obesity
    self.obesity =
      case imc
      when 25..29.99 then 'I'
      when 30..34.99 then 'II'
      when 35..Float::INFINITY then 'III'
      else 'Não obeso'
      end
  end
end