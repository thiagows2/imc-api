# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ImcCalculator', type: :request do
  describe 'POST /imc_calculators' do
    let(:json_response) { JSON.parse(response.body) }

    it 'severely underweight' do
      post calculate_imc_path(imc: { height: 1.7, weight: 40 })

      expect(json_response['imc']).to eq(13.9)
      expect(json_response['classification']).to eq('Peso severamente abaixo do normal')
      expect(json_response['obesity']).to eq('Não obeso')
    end

    it 'underweight' do
      post calculate_imc_path(imc: { height: 1.7, weight: 50 })

      expect(json_response['imc']).to eq(17.4)
      expect(json_response['classification']).to eq('Peso abaixo do normal')
      expect(json_response['obesity']).to eq('Não obeso')
    end

    it 'normal weight' do
      post calculate_imc_path(imc: { height: 1.7, weight: 60 })

      expect(json_response['imc']).to eq(20.8)
      expect(json_response['classification']).to eq('Normal')
      expect(json_response['obesity']).to eq('Não obeso')
    end

    it 'overweight I' do
      post calculate_imc_path(imc: { height: 1.7, weight: 80 })

      expect(json_response['imc']).to eq(27.7)
      expect(json_response['classification']).to eq('Sobrepeso')
      expect(json_response['obesity']).to eq('I')
    end

    it 'overweight grade II' do
      post calculate_imc_path(imc: { height: 1.7, weight: 100 })

      expect(json_response['imc']).to eq(34.7)
      expect(json_response['classification']).to eq('Sobrepeso')
      expect(json_response['obesity']).to eq('II')
    end

    it 'overweight grade III' do
      post calculate_imc_path(imc: { height: 1.7, weight: 200 })

      expect(json_response['imc']).to eq(69.3)
      expect(json_response['classification']).to eq('Sobrepeso')
      expect(json_response['obesity']).to eq('III')
    end
  end
end
