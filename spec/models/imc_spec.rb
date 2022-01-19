require 'rails_helper'

RSpec.describe Imc, type: :model do
  context 'with basic validations' do
    it { is_expected.to validate_presence_of :height }
    it { is_expected.to validate_presence_of :weight }
    
    it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:weight).is_greater_than(0) }
  end
end

