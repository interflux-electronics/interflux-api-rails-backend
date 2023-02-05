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
  # export RAILS_ENV=production
  # bin/rails translations:fix
  task fix: :environment do
    puts '---------'
    puts 'Creating missing translations'
    puts '---------'

    languages = %w[en de es fr]

    Translation.where(language: 'en').each do |en|
      languages.each do |lang|
        record = Translation.find_by(language: lang, key: en.key)

        if record.nil?
          new_record = Translation.create!(
            key: en.key,
            language: lang,
            english: en.native,
            needs_review: true,
            review_code: 'untranslated'
          )
          TranslationEvent.create!(code: 'created', updated_by: 'Jan Werkhoven', translation: new_record)
          puts "#{en.key} | #{lang} | CREATED"
        else
          puts "#{en.key} | #{lang} | ok"
        end
      end
    end
    puts '---------'
    puts 'Done'
    puts '---------'
  end

  # Usage:
  # export RAILS_ENV=production
  # bin/rails translations:fix
  task clean: :environment do
    puts '---------'
    puts 'Destroy unlinked translations'
    puts '---------'

    destroy_counter = 0

    Translation.all.each do |trans|
      if trans.language == 'en'
        puts "#{trans.key} | #{trans.language} | ok"
        next
      end

      english_counterpart = Translation.find_by(language: 'en', key: trans.key)

      if english_counterpart.nil?
        puts "#{trans.key} | #{trans.language} | DESTROY"
        trans.destroy!
        destroy_counter += 1
      else
        puts "#{trans.key} | #{trans.language} | ok"
      end
    end
    puts '---------'
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
