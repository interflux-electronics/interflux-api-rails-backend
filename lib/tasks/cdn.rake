# On server
# sudo apt-get s3cmd
# sudo apt-get install gpg
# s3cmd --configure

namespace :cdn do
  desc 'For each file in the CDN we need a database entry. This task helps us sync CDN and database.'

  task report: :environment do
    puts 'comparing CDN to database...'
    db = CdnFile.all.map(&:path)
    cdn = `s3cmd ls s3://cdn-interflux/ --recursive`.scan(%r{s3://cdn-interflux/(.*)\n}).flatten
    to_add = cdn.filter { |x| !db.include? x }
    to_remove = db.filter { |x| !cdn.include? x }
    puts '------'
    puts 'To add to database:'
    if to_add.empty?
      puts 'nothing'
    else
      to_add.sort.each do |path|
        puts "ADD #{path}"
      end
    end
    puts '------'
    puts 'To remove from database:'
    if to_remove.empty?
      puts 'nothing'
    else
      to_remove.sort.each do |path|
        puts "REMOVE #{path}"
      end
    end
    puts '------'
    puts "DB:  #{db.length}"
    puts "CDN: #{cdn.length}"
    puts '------'

    images_to_add = to_add.select { |x| x.starts_with?('images/') }
    videos_to_add = to_add.select { |x| x.starts_with?('videos/') }
    documents_to_add = to_add.select { |x| x.starts_with?('documents/') }
    others_to_add = to_add - images_to_add - videos_to_add - documents_to_add

    puts 'TO ADD'
    puts "images: #{images_to_add.length}"
    puts "videos: #{videos_to_add.length}"
    puts "docs:   #{documents_to_add.length}"
    puts "other:  #{others_to_add.length}"
    puts '------'

    images_to_remove = to_remove.select { |x| x.starts_with?('images/') }
    videos_to_remove = to_remove.select { |x| x.starts_with?('videos/') }
    documents_to_remove = to_remove.select { |x| x.starts_with?('documents/') }
    others_to_remove = to_remove - images_to_remove - videos_to_remove - documents_to_remove

    puts 'TO REMOVE'
    puts "images: #{images_to_remove.length}"
    puts "videos: #{videos_to_remove.length}"
    puts "docs:   #{documents_to_remove.length}"
    puts "other:  #{others_to_remove.length}"
    puts '------'
  end

  task sync: :environment do
    puts 'comparing CDN to database...'
    db = CdnFile.all.map(&:path)
    cdn = `s3cmd ls s3://cdn-interflux/ --recursive`.scan(%r{s3://cdn-interflux/(.*)\n}).flatten
    to_add = cdn.filter { |x| !db.include? x }
    to_remove = db.filter { |x| !cdn.include? x }
    puts '------'
    puts 'To add to database:'
    if to_add.empty?
      puts 'nothing'
    else
      to_add.sort.each do |path|
        puts "ADD #{path}"
        props = OpenStruct.new(
          path: path
        )
        CdnFile.create!(props.to_h)
        puts 'done'
      end
    end
    puts '------'
    puts 'To remove from database:'
    if to_remove.empty?
      puts 'nothing'
    else
      to_remove.sort.each do |path|
        puts "REMOVE #{path}"
        record = CdnFile.find_by(path: path)
        record.destroy
        puts 'done'
      end
    end
    puts '------'
    puts "DB:  #{db.length}"
    puts "CDN: #{cdn.length}"
    puts '------'

    images_to_add = to_add.select { |x| x.starts_with?('images/') }
    videos_to_add = to_add.select { |x| x.starts_with?('videos/') }
    documents_to_add = to_add.select { |x| x.starts_with?('documents/') }
    others_to_add = to_add - images_to_add - videos_to_add - documents_to_add

    puts 'ADDED'
    puts "images: #{images_to_add.length}"
    puts "videos: #{videos_to_add.length}"
    puts "docs:   #{documents_to_add.length}"
    puts "other:  #{others_to_add.length}"
    puts '------'

    images_to_remove = to_remove.select { |x| x.starts_with?('images/') }
    videos_to_remove = to_remove.select { |x| x.starts_with?('videos/') }
    documents_to_remove = to_remove.select { |x| x.starts_with?('documents/') }
    others_to_remove = to_remove - images_to_remove - videos_to_remove - documents_to_remove

    puts 'REMOVED'
    puts "images: #{images_to_remove.length}"
    puts "videos: #{videos_to_remove.length}"
    puts "docs:   #{documents_to_remove.length}"
    puts "other:  #{others_to_remove.length}"
    puts '------'
  end
end
