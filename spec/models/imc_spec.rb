require 'rails_helper'

RSpec.describe Imc, type: :model do
  context 'with basic validations' do
    it { is_expected.to validate_presence_of :height }
    it { is_expected.to validate_presence_of :weight }
    
    it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:weight).is_greater_than(0) }
  end

  describe '#imc_calculator' do
    context 'with default calculation' do
      it { expect(imc_spec.imc).to eq(26.3) }
      it { expect(imc_spec.classification).to eq('Sobrepeso') }
      it { expect(imc_spec.obesity).to eq('I') }
    end

    context 'with severely underweight IMC' do
      imc_spec = Imc.create!(height: 1.7, weight: 40)

      it { expect(imc_spec.imc).to eq(13.9) }
      it { expect(imc_spec.classification).to eq('Peso severamente abaixo do normal') }
      it { expect(imc_spec.obesity).to eq('Não obeso') }
    end
  end
end

