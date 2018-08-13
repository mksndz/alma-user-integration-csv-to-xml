require_relative 'lib/objects/util'

LOG_FILE = './run.log'.freeze
SECRETS_FILE = './config/secrets.yml'.freeze
XML_TEMPLATE_FILE = './lib/templates/user_xml_v2_template.xml.erb'.freeze
INSTITUTION_CONFIG_FILE = './config/inst.yml'.freeze

Util.initialize_logger
Util.load_secrets
Util.load_template
Util.load_institution_config

$inst.each do |i|
  puts "Running for #{i[0]}"
  files = i[1]
  puts "#{files.length} files configured"
  files.each do |file|
    # process the file
    # TODO: build users
    # TODO: generate XML
    # TODO: create and place ZIP in Alma location
  end
end


