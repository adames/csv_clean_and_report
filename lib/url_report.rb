require 'csv'
require 'uri'
require 'json'
require 'timeout'
require 'net/http'
require 'rubygems'
require 'bundler/setup'

def url_report(csv_path)
  number_ok = 0
  failures = {}

  # row_sep handles trailing \n
  # headers skips first row
  csv_read_settings = [
    row_sep: :auto,
    encoding: "bom|utf-8",
    headers: :first_row,
  ]

  CSV.foreach(csv_path, *csv_read_settings) do |row|
    url_json = row["impression_pixel_json"]
    # binding.pry
    next if url_json == "NULL" || url_json == "[]"
    urls = JSON.parse(url_json)
    urls.each do |url|
      url = url_filler(url)
      if url_success? url
        puts "#{row['tactic_id']} OK"
        number_ok += 1
      else
        puts "#{row['tactic_id']} Failed"
        failures[row['tactic_id']] = url
      end
    end
  end
  puts "Summary"
  puts "Number OK: #{number_ok}"
  puts "Number Failed: #{failures.length}"
  puts "Failures: \n#{failures}" if !failures.empty?
end

def url_filler(url)
  # replaces timestamp and other bracketed items with "x"
  url = url.gsub(/\[.*?\]/, "x")
  # replaces JS interpolation with x's
  url = url.gsub(/\$[ ]*{([^}]*)}/, "x")
end

def url_success?(url)
  begin
    uri = URI(url)
    Timeout::timeout(3) {
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        true
      else
        false
      end
    }
  # This rescue is a bit too permissive. Possible improvements:
    # parsing html better so it never fails at URI conversion
    # more custom url filler to add dummy data of the type requested
  rescue
    return false
  end
end
