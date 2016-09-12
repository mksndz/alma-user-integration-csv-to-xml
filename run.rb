require 'logger'
require 'ostruct'
require 'yaml'
require 'erb'
require 'csv'
require 'zip'
require 'net/sftp'
require './lib/objects/user'

LOG_FILE = './log.log'
SECRETS_FILE = './config/secrets.yml'
XML_TEMPLATE_FILE = './lib/templates/user_xml_v2_template.xml.erb'

log = Logger.new LOG_FILE

unless ARGV.length == 2
  puts 'Input and Output files not defined, using testing defaults'
  ARGV[0] = './data/sample.csv'
  ARGV[1] = './data/sample_output.xml'
  # exit
end

input_file = ARGV[0]
output_file = ARGV[1]

unless File.exist? input_file
  log.fatal 'Input file not found. Stopping.'
  exit
end

# Load configs

unless File.exist? SECRETS_FILE
  log.fatal "Secrets file could not be found @ #{SECRETS_FILE}. Stopping."
  exit
end

secrets = YAML.load_file SECRETS_FILE
unless secrets.is_a? Hash
  log.fatal 'Secrets config file not properly parsed. Stopping.'
  exit
end

# Load ERB Template
unless File.exist? XML_TEMPLATE_FILE
  log.fatal "Could not find XML template file @ #{XML_TEMPLATE_FILE}. Stopping."
  exit
end
template_file = File.open XML_TEMPLATE_FILE

# Initaialize Users Array and counter
users = []
users_count = 0

# Convert CSV data into User objects, storing in Array
row_count = 0
CSV.foreach(input_file, quote_char: '"') do |row|
  row_count += 1
  begin
    users << User.new(row)
    users_count += 1
  rescue StandardError => e
    log.error "Couldn't create User object from CSV row #{row_count}: #{e.message}"
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
defaults.secondary_id_type      = '01'

# Initialize XML
output.puts "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n<users>"

# Write User XML to output file
users.each do |user|
  begin
    output.puts(template.result(binding))
  rescue Exception => e
    log.error "Error creating XML for User #{user.primary_id}: #{e.message}" # todo reconsider use of primary id in logs when in production
  end
end

# Finish XML
output.puts '</users>'

# Write to file and close
output.flush
output.close

# zip file
alma_file = output_file.gsub('.xml','.zip')
begin
  Zip::File.open(alma_file, Zip::File::CREATE) do |zipfile|
    zipfile.add alma_file.gsub('./data/',''), output_file
  end
rescue Exception => e
  log.fatal "Problem with compressing XML file for delivery: #{e.message}"
  exit
end

# ftp file
remote_file = 'test/' + alma_file.gsub('./data/','')
begin
  Net::SFTP.start(secrets['ftp']['url'], secrets['ftp']['user'], password: secrets['ftp']['pass'], port: secrets['ftp']['port']) do |c|
    c.upload! alma_file, remote_file
  end
rescue Exception => e
  log.fatal "Problem delivering file to GIL FTP server: #{e.message}"
  exit
end

log.info 'Output created: ' + output_file
log.info 'Payload delivered: ' + remote_file
log.info 'Users included: ' + users_count.to_s



