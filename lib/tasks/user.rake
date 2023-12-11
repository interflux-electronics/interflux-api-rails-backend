namespace :user do
  desc "Here we store common tasks for managing users so superadmin doesn't have to do them in console"

  # Usage:
  # export RAILS_ENV=production
  # bin/rails user:create email=foo@bar password=1234 first_name=John last_name=Doe
  task create: :environment do
    puts 'Creating user'

    abort 'Abort, missing email' unless ENV['email']
    abort 'Abort, missing password' unless ENV['password']
    abort 'Abort, missing first_name' unless ENV['first_name']
    abort 'Abort, missing last_name' unless ENV['last_name']

    person = Person.find_by(
      first_name: ENV['first_name'],
      last_name: ENV['last_name']
    )

    props = OpenStruct.new(
      first_name: ENV['first_name'],
      last_name: ENV['last_name']
    )

    if person.nil?
      person = Person.create!(props.to_h)
      puts 'Created new person'
    else
      person.update!(props.to_h)
      puts 'Updated existing person'
    end

    user = User.find_by(
      email: ENV['email']
    )

    props = OpenStruct.new(
      email: ENV['email'],
      password: ENV['password'],
      person_id: person.id
    )

    if user.nil?
      User.create!(props.to_h)
      puts 'Created new user'
    else
      user.update!(props.to_h)
      puts 'Updated existing user'
    end
  end

  # Usage:
  # export RAILS_ENV=production
  # bin/rails user:delete email=foo@bar
  task delete: :environment do
    puts 'Deleting user'

    abort 'Abort, missing email' unless ENV['email']

    user = User.find_by(
      email: ENV['email']
    )

    if user.nil?
      puts 'No user found'
    else
      user.delete
      puts 'User deleted'
    end
  end

  # Usage:
  # export RAILS_ENV=production
  # bin/rails user:password email=foo@bar email=12345
  task password: :environment do
    puts 'Updating password'

    abort 'Abort, missing email' unless ENV['email']
    abort 'Abort, missing password' unless ENV['password']

    user = User.find_by(
      email: ENV['email']
    )

    props = OpenStruct.new(
      password: ENV['password']
    )

    if user.nil?
      puts 'No user found'
    else
      user.update!(props.to_h)
      puts 'User password updated'
    end
  end

  task assign_abilities: :environment do
    base = %w[
      access_admin

      create_products
      read_products
      update_products
      delete_products

      create_product_families
      read_product_families
      update_product_families
      delete_product_families

      create_uses
      read_uses
      update_uses
      delete_uses

      create_product_uses
      read_product_uses
      update_product_uses
      delete_product_uses

      create_qualities
      read_qualities
      update_qualities
      delete_qualities

      create_product_qualities
      read_product_qualities
      update_product_qualities
      delete_product_qualities

      create_documents
      read_documents
      update_documents
      delete_documents

      create_document_categories
      read_document_categories
      update_document_categories
      delete_document_categories

      create_events
      read_events
      update_events
      delete_events

      create_webinars
      read_webinars
      update_webinars
      delete_webinars

      create_images
      read_images
      update_images
      delete_images

      create_people
      read_people
      update_people
      delete_people

      create_companies
      read_companies
      update_companies
      delete_companies

      create_company_members
      read_company_members
      update_company_members
      delete_company_members

      create_company_markets
      read_company_markets
      update_company_markets
      delete_company_markets

      create_translations
      read_translations
      update_translations
      delete_translations

      create_permalinks
      read_permalinks
      update_permalinks

      create_videos
      read_videos
      update_videos
    ].join(',')

    translation_base = %w[
      create_translations
      read_translations
      update_translations
      delete_translations
    ].join(',')

    todos = [
      ['d.werkhoven@interflux.com', base],
      ['i.maris@interflux.com', base],
      ['jw@interflux.au', base],
      ['farrah@interflux.com.sg', base],
      ['r.lauwaert@interflux.com', base],
      ['s.teliszewski@interflux.com', base],
      ['wimvanriet@interflux.com.sg', base],
      ['a.peeters@interflux.com', base],
      ['c.guerrero@interflux.com', translation_base],
      ['d.laprade@interfluxfrance.com', translation_base]
    ]

    todos.each do |todo|
      email = todo[0]
      abilities = todo[1]
      user = User.find_by(email: email)
      abort "Abort, cannot find user for #{email}" if user.nil?
      user.abilities = abilities
      user.save!
    end
  end
end
