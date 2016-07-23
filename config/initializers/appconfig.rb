require 'ostruct'
require 'yaml'

erb = ERB.new(File.read("#{Rails.root}/config/config.yml")).result
all_config = YAML.load(erb) || {}
env_config = all_config[Rails.env] || {}
AppConfig = OpenStruct.new(env_config)
