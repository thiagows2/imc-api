class Imc < ApplicationRecord
  IMC_CATEGORIES = %w[severely_underweight underweight healthy_weight overweight obesity].freeze
  OBESITY = %w[I II III]

  validates :height, :weight, presence: true

  before_save :imc_calculator

  def imc_calculator
    self.imc = (weight / height ** 2).ceil(1)

    define_classification
  end

  def define_classification
    debugger
  end
end