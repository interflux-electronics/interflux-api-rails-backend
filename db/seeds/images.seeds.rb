puts '---------'
puts 'Seeding images'
puts '---------'

cdn_files = CdnFile.all

cdn_files.each do |file|
  # Skip all CDN paths that aren't these 4 type of images
  next unless [
    'images/products/',
    'images/processes/',
    'images/logos/',
    'images/icons/'
  ].any? { |x| file.path.start_with?(x) }

  puts file.path

  # shared_path = file.path.split('@').first
  shared_path = if file.path.include? '@' then file.path.split('@').first else file.path.split('.').first end

  image = Image.find_by(path: shared_path)

  if image.present?
    puts "SKIP"
    next
  end

  subset = cdn_files.filter { |x| x.path.start_with?("#{shared_path}@") } if file.path.include? '@'
  subset = cdn_files.filter { |x| x.path.start_with?("#{shared_path}.") } if file.path.exclude? '@'

  variations = subset.map { |x| "@#{x.path.split('@').last}" } .sort_by { |x| x.split('x').first.to_i } .join(',') if file.path.include? '@'
  variations = subset.map { |x| ".#{x.path.split('.').last}" } .join(',') if file.path.exclude? '@'

  props = OpenStruct.new(
    path: shared_path,
    alt: shared_path.split('/').last.gsub('-', ' '),
    variations: variations
  )

  image = Image.create!(props.to_h)

  puts "CREATED" if image.present?

  subset.each do |cdn_file|
    cdn_file.image_id = image.id
    cdn_file.save!
  end
end

puts '---------'
puts 'Success!'
puts '---------'
puts ' '
