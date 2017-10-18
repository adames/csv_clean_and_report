require 'csv'
require 'rubygems'
require 'bundler/setup'

def impression_pixel_http_cleaner(csv_path)

  # row_sep handles trailing \n
  csv_read_settings = [
    row_sep: :auto,
    encoding: "bom|utf-8",
  ]

  clean_csv_array = []

  CSV.foreach(csv_path, *csv_read_settings) do |row|

    # adds headers to new array
    if row.class == Array
      clean_csv_array << row.join(',')
      next
    end

    row["impression_pixel_json"] = row["impression_pixel_json"].gsub(/http:/, "https:")
    clean_csv_array << row.to_s.chomp
  end

  return clean_csv_array.join(",")
end
