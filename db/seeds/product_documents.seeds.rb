after :documents, :products do
  puts '---------'
  puts 'Seeding product documents'
  puts '---------'

  # file = File.read 'db/seeds/data/cdn_files.yml'
  # paths = YAML.safe_load(file)

  Document.all.each_with_index do |document, i|
    next unless document.path.start_with?('documents/products/')

    slug = document.path.split('/').third
    product = Product.find_by(slug: slug)
    byebug if product.nil?

    props = OpenStruct.new(
      product_id: product.id,
      document_id: document.id,
    )

    record = ProductDocument.find_by(document_id: document.id, product_id: product.id)

    if record.nil?
      ProductDocument.create!(props.to_h)
    else
      record.update!(props.to_h)
    end

    document.name = "TD #{product.name}"
    document.name = document.name + " SnPb(Ag)" if document.path.include? "SnPbAg"
    document.save!

    puts "#{i} | #{product.slug} | #{document.path}"
  end

  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
