# TODO: Remove all documents from database that aren't in the CDN

after :document_categories, :languages do
  puts '---------'
  puts 'Seeding documents'
  puts '---------'

  file = File.read 'db/seeds/data/cdn_files.yml'
  paths = YAML.safe_load(file)

  languages = Language.all

  paths.each_with_index do |path, i|
    # Skip all CDN paths that aren't documents
    next unless path.start_with?('documents/')

    language = path.split('-').last.split('.').first.downcase
    language = Language.find_by(iso_639_1_code: language)

    category = path.split('/').second
    category = 'TD' if category == 'series'
    category = 'TD' if category == 'products'
    category = DocumentCategory.find_by(slug: category)

    name = path.split('/').last.split('.').first[0...-3].gsub("-", " ")

    byebug if language.nil?
    byebug if category.nil?

    props = OpenStruct.new(
      path: path,
      name: name,
      language_id: language.id,
      category_id: category.id,
    )

    document = Document.find_by(path: path)

    if document.nil?
      Document.create!(props.to_h)
    else
      document.update!(props.to_h)
    end

    puts "#{i} | #{category.name} | #{language.name_english} | #{path}"
  end

  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
