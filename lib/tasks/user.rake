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
    todos = [
      ['d.werkhoven@interflux.com', 'access_admin'],
      ['i.maris@interflux.com', 'access_admin'],
      ['j.werkhoven@interflux.com', 'access_admin,write_users'],
      ['farrah@interflux.com.sg', 'access_admin'],
      ['r.lauwaert@interflux.com', 'access_admin'],
      ['s.teliszewski@interflux.com', 'access_admin'],
      ['wimvanriet@interflux.com.sg', 'access_admin'],
      ['a.peeters@interflux.com', 'access_admin']
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
