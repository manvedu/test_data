RSpec.describe 'ComparisonProcessorContract' do
  let(:comparison_processor_contract) {ComparisonProcessorContract.new}
  let(:input) do
    {
      file_path: './soccer.dat',
      header_clue: '<pre>',
      footer_clue: '</pre>',
      select_operation: 'max',
      minuend_index: 2,
      subtrahend_index: 1,
      column_to_return_index: 0,
      blank_spaces_between_footer_and_last_row: 2,
      blank_spaces_between_header_and_first_row: 2
    }
  end
  it 'when the input is the expected one, return success' do
    result = comparison_processor_contract.call(input)
    expect(result.success?).to be_truthy
  end
  describe 'select_operation' do
    it 'when is a not permitted value, return failure' do
      result = comparison_processor_contract.call( input.merge(select_operation: 'concat') )
      expect(result.failure?).to be_truthy
    end
  end
  context 'for string fields' do
    %w(file_path header_clue footer_clue select_operation).each do |attr|
      it 'when is no a string, return failure' do
        result = comparison_processor_contract.call( input.merge(attr.to_sym => 123) )
        expect(result.failure?).to be_truthy
      end
      it 'when is no present, return failure' do
        result = comparison_processor_contract.call( input.except(attr.to_sym ) )
        expect(result.failure?).to be_truthy
      end
      it 'when is nil, return failure' do
        result = comparison_processor_contract.call( input.merge(attr.to_sym => nil) )
        expect(result.failure?).to be_truthy
      end
    end
  end
  context 'for integer fields' do
    %w(minuend_index subtrahend_index column_to_return_index blank_spaces_between_footer_and_last_row blank_spaces_between_header_and_first_row).each do |attr|
      it 'when is no a string, return failure' do
        result = comparison_processor_contract.call( input.merge(attr.to_sym => 'abc') )
        expect(result.failure?).to be_truthy
      end
      it 'when is no present, return failure' do
        result = comparison_processor_contract.call( input.except(attr.to_sym ) )
        expect(result.failure?).to be_truthy
      end
      it 'when is nil, return failure' do
        result = comparison_processor_contract.call( input.merge(attr.to_sym => nil) )
        expect(result.failure?).to be_truthy
      end
    end
  end
end
