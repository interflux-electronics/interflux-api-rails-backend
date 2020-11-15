after :cdn_files do
  puts '---------'
  puts 'Seeding images'
  puts '---------'

  Image.delete_all

  cdn_files = CdnFile.all

  cdn_files.each do |file|
    # Skip all CDN paths that aren't these 4 type of images
    next unless [
      'images/products/',
      'images/processes/',
      'images/logos/',
      'images/icons/'
    ].any? { |x| file.path.start_with?(x) }

    shared_path = file.path.split('@').first

    image = Image.find_by(path: shared_path)

    puts "SKIP #{file path}"  if image.present?
    next if image.present?

    subset = cdn_files.filter { |x| x.path.start_with?(shared_path) }

    props = OpenStruct.new(
      path: shared_path,
      alt: shared_path.split('/').last.gsub('-', ' '),
      variations: subset.map { |x| x.path.split('@').last } .sort_by { |x| x.split('x').first.to_i } .join(',')
    )

    image = Image.create!(props.to_h)

    puts "DONE #{file path}"  if image.present?

    subset.each do |cdn_file|
      cdn_file.image_id = image.id
      cdn_file.save!
    end
  end

  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
