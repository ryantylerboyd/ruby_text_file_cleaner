# read in files in your current directory this is located
pdf_files = Dir["*.text"].to_a.map! {|a| __dir__ + "/" + a}
pdf_files.each do |pdf_file_location|
    if `file --brief --mime-type #{pdf_file_location}`.strip.to_s == "text/plain"

    temp_data = []
    puts "Working on file #{pdf_file_location}"

    # Open the file data to the reader
    File.open(pdf_file_location, "rb") do |io|
      io.each do |line|
        data = line
        # Remove CR+LF
        data = data.gsub('\r','')

        # Remove trailing & forward whitespace
        data = data.strip

        # Replace tabs with whitespace
        data = data.gsub(/$\t/,'')

        # Compress two or more consecutive blank datas
        data = data.gsub(/[ ]{2}/,'')

        # Removes double new line
        data = data.gsub('\n\n','\n')

        # save data to an array
        temp_data << data
      end
    end
    temp_data << "\n"
    print temp_data
    File.open(pdf_file_location, "w+") do |f|
      temp_data.each { |element| f.puts(element) }
    end
  end
end
