# Main Script
# Requires two command-line parameters
# Input File
# Output File

require './lib/objects/user'
require 'ostruct'
require 'erb'
require 'csv'

unless ARGV.length == 2
  puts 'Input and Output files not defined, using testing defaults'
  ARGV[0] = './data/sample.csv'
  ARGV[1] = './data/sample_output.xml'
  # exit
end

input_file = ARGV[0]
output_file = ARGV[1]

# Load ERB Template
template_file = File.open('./lib/templates/user_xml_v2_template.xml.erb')

# Initaialize Users Array and counter
users = []
users_count = 0

# Convert CSV data into User objects, storing in Array
row_count = 0
CSV.foreach(input_file, quote_char: "'") do |row|
  row_count += 1
  begin
    users << User.new(row)
    users_count += 1
  rescue StandardError => e
    puts "Couldn't create User object from CSV row #{row_count}: #{e.message}"
  end
end

# Read template
template = ERB.new(template_file.read)

# Create and Open output file
output = File.open(output_file , 'w+')

# Define default values for XML
# todo: load from config as they may be different per institution? or hopefully not
defaults = OpenStruct.new
defaults.preferred_address_type = 'HOME'
defaults.preferred_phone_type   = 'MOBILE'
defaults.preferred_email_type   = 'PERSONAL'

# Initialize XML
output.puts "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n<users>"

# Write User XML to output file
users.each do |user|
  output.puts(template.result(binding))
end

# Finish XML
output.puts '</users>'

# Write to file and close
output.flush
output.close

puts 'Output created: ' + output_file
puts 'Users included: ' + users_count.to_s




