require 'dry-validation'

class ComparisonProcessorContract < Dry::Validation::Contract
  schema do
    required(:file_path).filled(:string)
    required(:header_clue).filled(:string)
    required(:footer_clue).filled(:string)
    required(:select_operation).value(:string, included_in?: ['max', 'min'])
    required(:minuend_index).filled(:integer)
    required(:subtrahend_index).filled(:integer)
    required(:column_to_return_index).filled(:integer)
    required(:blank_spaces_between_footer_and_last_row).filled(:integer)
    required(:blank_spaces_between_header_and_first_row).filled(:integer)
  end
end
