# Important:
#
# Every deployment to production will seed, fix and clean the database translations:
#
# bin/rails db:seed:translations
# bin/rails translations:fix
# bin/rails translations:clean
#
# The source of truth for English UI translations is the seed file, not the database.
# The source of truth for English record translations is the database.
# The source of truth for non-English languages is always the database.
#
# That said, the only translations which are hard coded are the English ones for the UI to render.

namespace :translations do
  desc 'Common tasks for managing translations'

  # Usage:
  # bin/rails translations:sync
  task sync: :environment do
    puts '---------'
    puts 'Syncing translations'
    puts '---------'

    locations = Translation.distinct.pluck(:location)
    languages = %w[de fr es zh nl]

    locations.each do |loc|
      languages.each do |lang|
        record = Translation.find_by(location: loc, language: lang)
        if record.present?
          puts "#{loc} #{lang} ok"
        else
          puts "#{loc} #{lang} CREATING!"
          Translation.create!(
            location: loc,
            language: lang,
            english: Translation.find_by(location: loc).english,
            status: 'to-translate'
          )
        end
      end
    end
  end

  # Usage:
  # bin/rails translations:clean
  task clean: :environment do
    puts '---------'
    puts 'Cleaning up translations'
    puts '---------'

    destroy_counter = 0

    exact_locations_to_delete = [
      'footer.1',
      'footer.10',
      'footer.11',
      'footer.12',
      'footer.13',
      'footer.14',
      'footer.15',
      'footer.16',
      'footer.17',
      'footer.18',
      'footer.19',
      'footer.2',
      'footer.3',
      'footer.4',
      'footer.5',
      'footer.6',
      'footer.7',
      'footer.8',
      'footer.9',
      'header.38',
      'header.39',
      'product.6',
      'products.10',
      'products.10',
      'products.11',
      'products.12',
      'products.13',
      'products.2',
      'products.3',
      'products.5',
      'products.6',
      'products.7',
      'products.8',
      'products.9',
      'seo.2',
      'webinars.13',
      'webinars.14'
    ]

    exact_locations_to_delete.each do |location|
      records = Translation.where(location: location)
      records.each do |record|
        puts "destroying #{location} #{record.language}..."
        record.destroy!
        destroy_counter += 1
        puts '---------'
      end
    end

    starting_with_locations_to_delete = [
      'products.10',
      'products.13',
      'products.5',
      'products.6',
      'products.7',
      'products.9',
      'seo.5',
      'seo.6',
      'seo.7'
    ]

    # TODO: optimise with
    # Translation.where("location ~ ?", '^seo.5')

    starting_with_locations_to_delete.each do |location|
      records = Translation.all.select { |t| t.location.starts_with? location }
      records.each do |record|
        puts "destroying #{record.location} #{record.language}..."
        record.destroy!
        destroy_counter += 1
        puts '---------'
      end
    end

    records_with_undefined_location = Translation.all.select { |t| t.location.include? 'undefined' }
    records_with_undefined_location.each do |record|
      puts "destroying #{record.location} #{record.language}..."
      record.destroy!
      destroy_counter += 1
      puts '---------'
    end

    # Aparently 80 records have
    # :language => "login",
    language_login = Translation.where(language: 'login')
    language_login.each do |record|
      puts "destroying #{record.location} #{record.language}..."
      record.destroy!
      destroy_counter += 1
      puts '---------'
    end

    puts "Destroyed #{destroy_counter}"
    puts '---------'
    puts 'Done'
    puts '---------'
  end

  task translate: :environment do
    abort 'Abort, missing phrase' unless ENV['phrase']
    abort 'Abort, missing source_lang' unless ENV['source_lang']
    abort 'Abort, missing target_lang' unless ENV['target_lang']
    TranslateService.new(ENV.fetch('phrase', nil), ENV.fetch('source_lang', nil), ENV.fetch('target_lang', nil)).call
  end

  task open_all_product_pages: :environment do
    commands = []
    Product.where(public: true).each do |product|
      puts product.slug
      commands.push("open https://interflux.de/product/#{product.slug}")
      commands.push('sleep 1')
    end
    exec(commands.join(' && '))
  end
end
