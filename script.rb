file = File.read('w_data.dat')
data_splitted = data.split("\n")
table_header_index = data_splitted.index{|row| row.include?('MxT')}
table_last_row_index = data_splitted.index{|row| row.include?('/pre')} - 2
table_data = data_splitted[table_header_index+2..table_last_row_index]

sorted_data = table_data.map do |row|
  fields = row.split(' ')
  day = day
  max_temp = fields[1].to_f
  min_temp = fields[2].to_f
  spread = (max_temp - min_temp)
  {day: day, spread: spread}
end
max_spread = sorted_data.max_by{ |v| v[:spread] }.fetch(:spread)
max_days = sorted_data.select{|v| v[:spread].eql?(max_spread) }.map{|v| v[:day]}.uniq.join(', ')
result = "The days with max spread are: #{max_days}"


######
file = File.read('soccer.dat')
data_splitted = data.split("\n")
table_header_index = data_splitted.index{|row| row.include?('MxT')}
table_last_row_index = data_splitted.index{|row| row.include?('/pre')} - 2
table_data = data_splitted[table_header_index+2..table_last_row_index]

sorted_data = table_data.map do |row|
  fields = row.split(' ')
  day = fields[0]
  max_temp = fields[1].to_f
  min_temp = fields[2].to_f
  spread = (max_temp - min_temp)
  {day: fields[0], spread: spread}
end
max_spread = sorted_data.max_by{ |v| v[:spread] }.fetch(:spread)
max_days = sorted_data.select{|v| v[:spread].eql?(max_spread) }.map{|v| v[:day]}.uniq.join(', ')
result = "The days with max spread are: #{max_days}"


#class DataProcessor
class ComparisionProcessor
    header_clue: '<pre>',
    footer_clue: '</pre>',
    #select_operation: 'max', #Preferable to break it than having a result that is not the expected one
    select_operation: ,
    minuend_index:,
    subtrahend_index:,
    column_to_return_index:,
    blank_spaces_between_footer_and_last_row:,
    blank_spaces_between_header_and_first_row:,

  def initialize(
    validator: ComparisionProcessorContract.new
  )
    @validator = validator
  end

  def self.validate(input)
  end

  def self.get_data(file_path)
    File.read('w_data.dat')
  end

  def self.data_in_rows(string_data)
    data_splitted = data.split("\n")
  end

  def self.find_table_index_header
    data_splitted.index{|row| row.include?(@header_clue)} + blank_spaces_between_header_and_first_row
  end

  def self.get_index_by_clue(clue)
    data_splitted.index{|row| row.include?(clue)}
  end

  def self.set_first_row_index
    self.get_index_by_clue(@header_clue) + blank_spaces_between_header_and_first_row
  end

  def self.set_last_row_index
    self.get_index_by_clue(@footer_clue)- blank_spaces_between_footer_and_last_row
  end

  def self.get_required_rows(input)
    data_splitted[self.set_first_row_index..self.set_last_row_index]
  end

  def self.get_required_rows(input)
    table_data = self.get_required_rows(input)
    processed_data = table_data.map do |row|
      fields = row.split(' ')
      selected_column = fields[column_to_return_index]
      minuend = fields[minuend_index].to_f
      subtrahend = fields[subtrahend_index].to_f
      difference_result = (minuend - subtrahend)
      {result_column: selected_column, difference_result: difference_result}
    end
    input.merge(processed_data: processed_data)
  end

  def self.apply_filter_operation(input)
    processed_data = input.fetch(:processed_data)
    wanted_value = if input(:select_operation) == 'max'
      processed_data.max_by{ |v| v[:difference_result] }.fetch(:difference_result)
    elsif input(:select_operation) == 'min'
      processed_data.min_by{ |v| v[:difference_result] }.fetch(:difference_result)
    else
      raise "Error no valid operation"
    end
    input.merge(wanted_value: wanted_value)
  end

  def self.get_all_matches(input)
    processed_data = input.fetch(:processed_data)
    wanted_value = input.fetch(:wanted_value)
    processed_data.select{|v| v[:difference_result].eql?(wanted_value) }.map{|v| v[:result_column]}.uniq.join(', ')
  end
end

  def initialize(
  )
    @header_clue = header_clue
    @footer_clue = footer_clue
    @select_operation: ,
    minuend_index:,
    subtrahend_index:,
    column_to_return_index:,
    blank_spaces_between_footer_and_last_row:,
    blank_spaces_between_header_and_first_row:,
  end
