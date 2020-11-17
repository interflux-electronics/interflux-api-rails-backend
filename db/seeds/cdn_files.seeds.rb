puts '---------'
puts 'Seeding files'
puts '---------'

file = File.read 'db/seeds/data/cdn_files.yml'
paths = YAML.safe_load(file)

if paths.count != CdnFile.count
  paths.each_with_index do |path, i|
    props = OpenStruct.new(
      path: path
    )

    record = CdnFile.find_by(path: path)

    next unless record.nil?

    puts "#{i} | #{path}"

    CdnFile.create!(props.to_h)
  end
else
  puts 'skipping'
end

puts '---------'
puts 'Success!'
puts '---------'
puts ' '
