require 'csv'

class TwitterApiParser

  def process_rows(csv_file_path)

    malformed_row_count = 1
    row_count = 1
    IO.foreach(csv_file_path) do |line|

      begin
        line = line.gsub("'", "")
        line = line.gsub('"', "")
        parsed_row = CSV.parse_line(line)

        row_count = row_count + 1
      rescue CSV::MalformedCSVError => e
        puts "The malformed count is: #{malformed_row_count}"
        puts "The is a malformed row count is: #{row_count}"
        puts "The line is: #{line}"
        malformed_row_count = malformed_row_count +1
        row_count = row_count + 1
      end


    end

    puts "The total malformed lines are: #{malformed_row_count}"

  end

end