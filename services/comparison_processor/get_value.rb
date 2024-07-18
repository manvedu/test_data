require 'dry/monads'

module ComparisionProcessor
  class GetValue
    include Dry::Monads[:result, :do, :maybe]

    def initialize(
      validator: ComparisonProcessorContract.new
    )
      @validator = validator
    end
 
    def call(input)
      input = yield validate(input)
      input = yield get_data(input)
      input = yield split_data_in_rows(input)
      input = yield get_required_rows(input)
      input = yield proccess_rows(input)
      input = yield apply_filter_operation(input)
      get_all_matches(input)
    end

    private

    def validate(input)
      result = @validator.call(input)
      result.success? ? Dry::Monads::Success(input) : Dry::Monads::Failure(result.errors.to_h)
    end
 
    def get_data(input)
      data = File.read( input.fetch(:file_path) )
      Dry::Monads::Success( input.merge(file_data: data) )
    rescue Errno::ENOENT
      Dry::Monads::Failure('The file can\'t be opened')
    end
 
    def split_data_in_rows(input)
      Dry::Monads::Success(
        input.merge( data_rows: input.fetch(:file_data).split("\n") )
      )
    end
 
    def get_required_rows(input)
      data_rows = input.fetch(:data_rows)
      first_row_index = get_first_row_index(data_rows: data_rows, clue: input.fetch(:header_clue), blank_spaces: input.fetch(:blank_spaces_between_header_and_first_row) )
      last_row_index = get_last_row_index(data_rows: data_rows, clue: input.fetch(:footer_clue), blank_spaces: input.fetch(:blank_spaces_between_footer_and_last_row) )
      required_rows = data_rows[first_row_index..last_row_index]
      #We can add more logic to handle whats going if there is no index??
      Dry::Monads::Success( input.merge(required_rows: required_rows) )
    end

    def proccess_rows(input)
      table_data = input.fetch(:required_rows)
      column_to_return_index = input.fetch(:column_to_return_index)
      minuend_index = input.fetch(:minuend_index)
      subtrahend_index = input.fetch(:subtrahend_index)
      processed_data = table_data.map do |row|
        fields = row.split(' ') #Here the parser data can be more complex, for our examples it's ok
        # TODO improve this validation
        next unless fields.count > 1
        selected_column = fields[column_to_return_index]
        #Add logic, what happens if I cant convert it to float??? :O
        minuend = fields[minuend_index].to_f
        subtrahend = fields[subtrahend_index].to_f
        abs_difference_result = (minuend - subtrahend).abs
        {result_column: selected_column, difference_result: abs_difference_result}
      end.compact
      #TODO same add some failures for cases above
      #What happen if all the file content is not valid? How to know it?
      if processed_data.compact.count.zero?
        Dry::Monads::Failure( 'There is not valid data' )
      else
        Dry::Monads::Success( input.merge(processed_data: processed_data) )
      end
    end

    def apply_filter_operation(input)
      processed_data = input.fetch(:processed_data)
      if input.fetch(:select_operation) == 'max'
        Success processed_data.max_by{ |v| v[:difference_result] }.fetch(:difference_result)
      elsif input.fetch(:select_operation) == 'min'
        
        Success processed_data.min_by{ |v| v[:difference_result] }.fetch(:difference_result)
      else
        Dry::Monads::Failure('Operation Error')
      end.fmap { |wanted_value| input.merge(wanted_value: wanted_value) }
    end
 
    def get_all_matches(input)
      processed_data = input.fetch(:processed_data)
      wanted_value = input.fetch(:wanted_value)
      Success processed_data.select{|v| v[:difference_result].eql?(wanted_value) }.map{|v| v[:result_column]}.uniq.join(', ')
    end

    def get_first_row_index(data_rows:, clue:, blank_spaces:)
      get_index_by_clue(data_rows: data_rows, clue: clue) + blank_spaces
    end
 
    def get_last_row_index(data_rows:, clue:, blank_spaces:)
      get_index_by_clue(data_rows: data_rows, clue: clue) - blank_spaces
    end

    def get_index_by_clue(data_rows:, clue:)
      data_rows.index{|row| row.include?(clue)}
    end
  end
end
