# Utility functions
module Util
  require 'yaml'
  require 'logger'
  def self.initialize_logger
    $logger = Logger.new LOG_FILE
  rescue StandardError => e
    exit("Logger could not be initialized @ #{LOG_FILE}")
  end

  def self.load_secrets
    $secrets = YAML.load_file SECRETS_FILE
  rescue StandardError => e
    fail_with "Secrets config file @ #{SECRETS_FILE} could not be loaded.", e
  end

  def self.load_template
    $template = File.open XML_TEMPLATE_FILE
  rescue StandardError => e
    fail_with(
      "Could not find XML template file @ #{XML_TEMPLATE_FILE}. Stopping.",
      e
    )
  end

  def self.load_institution_config
    $inst = YAML.load_file INSTITUTION_CONFIG_FILE
  rescue StandardError => e
    fail_with(
      "Could not load institution config @ #{INSTITUTION_CONFIG_FILE}",
      e
    )
  end

  def self.fail_with(message, e)
    $logger.fatal"#{message} : Exception: #{e.message}"
    exit
  end
end