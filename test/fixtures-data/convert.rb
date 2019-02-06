puts '---------'
puts 'Starting conversion ...'
puts '---------'
require 'yaml'
require 'byebug'
require 'ap'
data = YAML.load_file(File.join(__dir__, 'countries.yml'))
byebug
puts '---------'
puts 'Success!'
puts '---------'
