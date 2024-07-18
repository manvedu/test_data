RSpec.describe 'ComparisionProcessor::GetValue' do
  let(:service) {ComparisionProcessor::GetValue.new}
  let(:input) do
    {
      file_path: 'spec/support/files/w_data.dat',
      header_clue: '<pre>',
      footer_clue: '</pre>',
      select_operation: 'max',
      minuend_index: 1,
      subtrahend_index: 2,
      column_to_return_index: 0,
      blank_spaces_between_footer_and_last_row: 2,
      blank_spaces_between_header_and_first_row: 4
    }
  end
  describe '.call' do
    it 'return success with the expected data' do
      result = service.call(input)

      expect(result.success).to eq('9, 229')
    end
    #Just add this for testing min operation
    it 'return success with the expected result' do
      new_params = {
        file_path: 'spec/support/files/soccer.dat',
        blank_spaces_between_header_and_first_row: 2,
        blank_spaces_between_footer_and_last_row: 1,
        minuend_index: 6,
        subtrahend_index: 8,
        column_to_return_index: 1,
        select_operation: 'min'
      }
      new_input = input.merge(new_params)
      result = service.call(new_input)

      expect(result.success).to eq('Aston_Villa')
    end
    it 'return failure when the file has not valid data' do
      result = service.call( input.merge(file_path: 'spec/support/files/soccer_error.dat') )

      expect(result.success?).to be_falsey
      expect(result.failure).to eq('There is not valid data')
    end
    it 'when is not valid, return failure with error messages' do
      expected_result = {:select_operation=>["must be one of: max, min"]}

      result = service.call(input.merge(select_operation: 'greet'))

      expect(result.success?).to be_falsey
      expect(result.failure).to eq(expected_result)
    end
    it 'when is not valid file, return failure with error message' do
      expected_result = 'The file can\'t be opened'

      result = service.call(input.merge(file_path: 'greet'))

      expect(result.success?).to be_falsey
      expect(result.failure).to eq(expected_result)
    end
  end
end
