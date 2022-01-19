require 'rails_helper'

RSpec.describe Imc, type: :model do
  context 'with basic validations' do
    it { is_expected.to validate_presence_of :height }
    it { is_expected.to validate_presence_of :weight }
    
    it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:weight).is_greater_than(0) }
  end

  describe '#imc_calculator' do
    context 'with a valid params' do
      let(:imc_spec) { create(:imc, height: 1.7, weight: 76) }

      it 'default calculation' do
        expect(imc_spec.imc).to eq(26.3)
        expect(imc_spec.classification).to eq('Sobrepeso')
        expect(imc_spec.obesity).to eq('I')
      end

      it 'severely underweight' do
        imc_spec.update_column(:weight, 40)
        imc_spec.save

        expect(imc_spec.imc).to eq(13.9)
        expect(imc_spec.classification).to eq('Peso severamente abaixo do normal')
        expect(imc_spec.obesity).to eq('Não obeso')
      end

      it 'underweight' do
        imc_spec.update_column(:weight, 50)
        imc_spec.save

        expect(imc_spec.imc).to eq(17.4)
        expect(imc_spec.classification).to eq('Peso abaixo do normal')
        expect(imc_spec.obesity).to eq('Não obeso')
      end

      it 'normal weight' do
        imc_spec.update_column(:weight, 60)
        imc_spec.save

        expect(imc_spec.imc).to eq(20.8)
        expect(imc_spec.classification).to eq('Normal')
        expect(imc_spec.obesity).to eq('Não obeso')
      end

      it 'overweight I' do
        imc_spec.update_column(:weight, 80)
        imc_spec.save

        expect(imc_spec.imc).to eq(27.7)
        expect(imc_spec.classification).to eq('Sobrepeso')
        expect(imc_spec.obesity).to eq('I')
      end

      it 'overweight grade II' do
        imc_spec.update_column(:weight, 100)
        imc_spec.save

        expect(imc_spec.imc).to eq(34.7)
        expect(imc_spec.classification).to eq('Sobrepeso')
        expect(imc_spec.obesity).to eq('II')
      end

      it 'overweight grade III' do
        imc_spec.update_column(:weight, 200)
        imc_spec.save

        expect(imc_spec.imc).to eq(69.3)
        expect(imc_spec.classification).to eq('Sobrepeso')
        expect(imc_spec.obesity).to eq('III')
      end
    end
  end
end

