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
      imc_spec = Imc.create!(height: 1.7, weight: 76)

      it { expect(imc_spec.imc).to eq(26.3) }
      it { expect(imc_spec.classification).to eq('Sobrepeso') }
      it { expect(imc_spec.obesity).to eq('I') }
    end

    context 'with severely underweight' do
      imc_spec = Imc.create!(height: 1.7, weight: 40)

      it { expect(imc_spec.imc).to eq(13.9) }
      it { expect(imc_spec.classification).to eq('Peso severamente abaixo do normal') }
      it { expect(imc_spec.obesity).to eq('Não obeso') }
    end

    context 'with underweight' do
      imc_spec = Imc.create!(height: 1.7, weight: 50)

      it { expect(imc_spec.imc).to eq(17.4) }
      it { expect(imc_spec.classification).to eq('Peso abaixo do normal') }
      it { expect(imc_spec.obesity).to eq('Não obeso') }
    end

    context 'with normal weight' do
      imc_spec = Imc.create!(height: 1.7, weight: 60)

      it { expect(imc_spec.imc).to eq(20.8) }
      it { expect(imc_spec.classification).to eq('Normal') }
      it { expect(imc_spec.obesity).to eq('Não obeso') }
    end

    context 'with overweight I' do
      imc_spec = Imc.create!(height: 1.7, weight: 80)

      it { expect(imc_spec.imc).to eq(27.7) }
      it { expect(imc_spec.classification).to eq('Sobrepeso') }
      it { expect(imc_spec.obesity).to eq('I') }
    end

    context 'with overweight grade II' do
      imc_spec = Imc.create!(height: 1.7, weight: 100)

      it { expect(imc_spec.imc).to eq(34.7) }
      it { expect(imc_spec.classification).to eq('Sobrepeso') }
      it { expect(imc_spec.obesity).to eq('II') }
    end

    context 'with overweight grade III' do
      imc_spec = Imc.create!(height: 1.7, weight: 200)

      it { expect(imc_spec.imc).to eq(69.3) }
      it { expect(imc_spec.classification).to eq('Sobrepeso') }
      it { expect(imc_spec.obesity).to eq('III') }
    end
  end
end

