namespace :document do
  # Usage:
  # export RAILS_ENV=production
  # bin/rails cdn:update_document_locales
  task locales: :environment do
    puts 'Updating document locales'

    Document.all.each do |doc|
      puts '------'
      puts doc.path
      doc.files.each do |file|
        puts file.path

        locale = nil
        locale = 'en' if file.path.ends_with?('-EN.pdf')
        locale = 'en' if file.path.ends_with?('-EN-old.pdf')
        locale = 'de' if file.path.ends_with?('-DE.pdf')
        locale = 'de' if file.path.ends_with?('-DE-old.pdf')
        locale = 'fr' if file.path.ends_with?('-FR.pdf')
        locale = 'fr' if file.path.ends_with?('-FR-old.pdf')
        locale = 'es' if file.path.ends_with?('-ES.pdf')
        locale = 'ja' if file.path.ends_with?('-JA.pdf')

        puts locale

        file.update!(locale: locale)
      end
    end

    puts '------'
    puts 'TO REVIEW'
    Document.all.each do |doc|
      doc.files.each do |file|
        puts file.path.to_s if file.locale.nil?
      end
    end
    puts '------'
  end

  # Usage:
  # export RAILS_ENV=production
  # bin/rails cdn:category
  task category: :environment do
    DocumentCategory.all.each do |c|
      c.update(name_single: 'technical data sheet') if c.slug == 'TD'
      c.update(name_single: 'safety data sheet') if c.slug == 'SDS'
      c.update(name_single: 'certificate') if c.slug == 'certificates'
      c.update(name_single: 'declaration') if c.slug == 'declarations'
      c.update(name_single: 'guide') if c.slug == 'guides'
      c.update(name_single: 'presentation') if c.slug == 'presentations'
      c.update(name_single: 'webinar') if c.slug == 'webinars'
      puts c.name_single
    end
  end

  # Usage:
  # export RAILS_ENV=production
  # bin/rails cdn:products
  task products: :environment do
    props = OpenStruct.new(
      slug: 'products',
      name: 'Products'
    )
    DocumentCategory.create!(props.to_h)
  end

  task uuid: :environment do
    CdnFile.where.not(document: nil).each do |cdn_file|
      doc = Document.find_by(path: cdn_file.document_id)
      if doc.nil?
        puts 'done'
      else
        puts cdn_file.path
        puts doc.path
        puts '---'
        cdn_file.update(document: doc)
      end
    end

    puts '===================='

    ProductDocument.all.each do |pd|
      doc = Document.find_by(path: pd.document_id)
      if doc.nil?
        puts 'done'
      else
        puts pd.product_id
        puts pd.document_id
        puts '---'
        pd.update(document: doc)
      end
    end
  end
end
