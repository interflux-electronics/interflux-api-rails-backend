# TODO: Remove all images from database that aren't in the CDN

puts '---------'
puts 'Seeding images'
puts '---------'

count_before =  Image.count

file = File.read 'db/seeds/data/cdn_files.yml'
paths = YAML.safe_load(file)

arr = []

paths.each do |path|
  next unless path.start_with?('images/products/')
  path = path.split('@')[0]
  arr.push(path)
end

path_bases = arr.uniq

path_bases.each do |path_base|
  paths_with_same_base = paths.select { |p| p.start_with? "#{path_base}@" }

  sizes = []
  formats = []

  paths_with_same_base.each do |path|
    split = path.split('@')[1].split('.')
    sizes.push(split[0])
    formats.push(split[1])
  end

  sizes = sizes.uniq.sort_by { |s| -s.split('x').first.to_i } .join(',')
  formats = formats.uniq.sort.join(',')

  props = OpenStruct.new(
    path: path_base,
    sizes: sizes,
    formats: formats
  )

  puts path_base
  puts sizes
  puts formats
  puts '-------'

  record = Image.find_by(path: path_base)

  if record.nil?
    Image.create!(props.to_h)
  else
    record.update!(props.to_h)
  end
end

count_after =  Image.count

puts "Before: #{count_before}"
puts "After: #{count_after}"
puts '---------'
puts 'Success!'
puts '---------'
puts ' '
