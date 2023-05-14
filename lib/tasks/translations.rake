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
    languages = %w[de fr es]

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

    locations_to_delete = [
      'product.6',
      'products.8',
      'products.10',
      'products.11',
      'products.12',
      'webinars.13',
      'webinars.14',
      'footer.1',
      'footer.2',
      'footer.3',
      'footer.4',
      'footer.5',
      'footer.6',
      'footer.7',
      'footer.8',
      'footer.9',
      'footer.10',
      'footer.11',
      'footer.12',
      'footer.13',
      'footer.14',
      'footer.15',
      'footer.16',
      'footer.17',
      'footer.18',
      'footer.19'
    ]

    locations_to_delete.each do |location|
      records = Translation.where(location: location)
      records.each do |record|
        puts "destroying #{location} #{record.language}..."
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
end
